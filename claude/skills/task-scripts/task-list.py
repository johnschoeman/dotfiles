#!/usr/bin/env python3
"""Parse task files using .claude/docs/tasks.md config. Output compact JSON."""

import json
import re
import sys
from datetime import date, timedelta
from pathlib import Path


def find_repo_root():
    """Walk up from cwd to find .claude/docs/tasks.md."""
    d = Path.cwd()
    while d != d.parent:
        if (d / ".claude" / "docs" / "tasks.md").is_file():
            return d
        d = d.parent
    return Path.cwd()


def parse_config(config_text):
    """Parse .claude/docs/tasks.md into a config dict."""
    cfg = {
        "storage_type": "markdown-files",
        "path": "tasks/",
        "done_path": "tasks/_done/",
        "skip_files": set(),
        "fields": {},
        "board": {},
        "filename_pattern": None,
        "template": None,
    }

    current_section = None
    current_field = None

    for line in config_text.splitlines():
        stripped = line.strip()

        # Track top-level sections
        if stripped.startswith("## "):
            current_section = stripped[3:].strip().lower()
            current_field = None
            continue

        # Track field subsections
        if stripped.startswith("### ") and current_section == "fields":
            current_field = stripped[4:].strip().lower()
            cfg["fields"][current_field] = {"values": [], "default": None, "prompt": None}
            continue

        if not stripped or stripped.startswith("<!--"):
            continue

        # Parse bold key-value pairs: - **key:** value
        m = re.match(r"-\s+\*\*(\w[\w_]*):\*\*\s*(.*)", stripped)
        if m:
            key, val = m.group(1).lower(), m.group(2).strip()

            if current_section == "storage":
                if key == "type":
                    cfg["storage_type"] = val
                elif key == "path":
                    cfg["path"] = val
                elif key == "done_path":
                    cfg["done_path"] = val
                elif key == "skip_files":
                    cfg["skip_files"] = {s.strip() for s in val.split(",")}

            elif current_section == "fields" and current_field:
                if key == "values":
                    cfg["fields"][current_field]["values"] = [
                        v.strip() for v in val.split(",")
                    ]
                elif key == "default":
                    cfg["fields"][current_field]["default"] = val
                elif key == "prompt":
                    cfg["fields"][current_field]["prompt"] = val

            elif current_section == "board":
                cfg["board"][key] = val

            elif current_section == "filename":
                if key == "pattern":
                    cfg["filename_pattern"] = val

    # Parse template block if present
    tm = re.search(r"## Template\s*\n```\w*\n(.*?)```", config_text, re.DOTALL)
    if tm:
        cfg["template"] = tm.group(1).strip()

    # Parse task_line from board section
    tl = re.search(
        r"## Board.*?task_line:\*\*\s*`([^`]+)`", config_text, re.DOTALL
    )
    if tl:
        cfg["board"]["task_line"] = tl.group(1)

    return cfg


def detect_format(text):
    """Detect if a task file uses frontmatter or heading-based format."""
    if re.match(r"^---\s*\n", text):
        return "frontmatter"
    return "heading"


def parse_frontmatter(text):
    """Extract YAML frontmatter as a dict."""
    m = re.match(r"^---\s*\n(.*?)\n---", text, re.DOTALL)
    if not m:
        return {}
    fm = {}
    for line in m.group(1).splitlines():
        stripped = line.strip()
        if not stripped or stripped.startswith("-"):
            continue
        if ":" in line:
            key, _, val = line.partition(":")
            val = val.strip()
            if val:
                fm[key.strip()] = val
    return fm


def parse_heading_fields(text, fields_config):
    """Extract field values from heading-based format (## Field: Value)."""
    data = {}
    for line in text.splitlines():
        stripped = line.strip()
        m = re.match(r"^##\s+(\w[\w\s]*):\s*(.*)", stripped)
        if m:
            key = m.group(1).strip().lower().replace(" ", "_")
            val = m.group(2).strip()
            if val:
                # Normalize to lowercase if this field has configured values
                if fields_config and key in fields_config:
                    val = val.lower()
                data[key] = val
    return data


def parse_title(text):
    """Extract first # heading (not ##)."""
    # Skip frontmatter
    body = text
    if text.startswith("---"):
        m = re.match(r"^---.*?---\s*", text, re.DOTALL)
        if m:
            body = text[m.end() :]
    m = re.match(r"^#\s+(.+)", body.strip(), re.MULTILINE)
    return m.group(1).strip() if m else None


def collect_tasks(directory, cfg, done=False):
    """Read .md files from a directory and return parsed task dicts."""
    tasks = []
    if not directory.is_dir():
        return tasks

    skip = cfg["skip_files"] | {"_template.md", "_index.md"}
    field_names = list(cfg["fields"].keys()) if cfg["fields"] else None

    for f in sorted(directory.glob("*.md")):
        if f.name in skip or f.name.startswith("_"):
            continue

        text = f.read_text()
        fmt = detect_format(text)

        if fmt == "frontmatter":
            data = parse_frontmatter(text)
        else:
            data = parse_heading_fields(text, cfg["fields"])

        # Determine status field name (first field with status-like values, or "status")
        status_field = "status"
        if field_names:
            for fn in field_names:
                finfo = cfg["fields"][fn]
                if any(v in ("done", "now", "active", "completed") for v in finfo.get("values", [])):
                    status_field = fn
                    break

        status = data.get(status_field, "").lower()

        # For done directories, only include done/completed tasks
        if done and status not in ("done", "completed"):
            continue

        title = parse_title(text) or f.stem.replace("-", " ").title()

        task = {"file": f.name, "title": title}

        # Add configured fields
        if field_names:
            for fn in field_names:
                if fn == status_field:
                    continue
                task[fn] = data.get(fn, cfg["fields"][fn].get("default", ""))
        else:
            # Auto-detect: include all parsed fields except status
            for k, v in data.items():
                if k != status_field:
                    task[k] = v

        if status in ("done", "completed"):
            task["completed"] = data.get("completed", "")
        else:
            task["created"] = data.get("created", "")

        task["status"] = status
        tasks.append(task)

    return tasks


def sort_tasks(tasks, sort_field, cfg):
    """Sort tasks by a field, using config values order if available."""
    if sort_field in cfg["fields"]:
        values = cfg["fields"][sort_field].get("values", [])
        order = {v: i for i, v in enumerate(values)}
        default_idx = len(values)
        return sorted(tasks, key=lambda t: order.get(t.get(sort_field, ""), default_idx))
    # Fallback: alphabetical
    return sorted(tasks, key=lambda t: t.get(sort_field, ""))


def main():
    root = find_repo_root()
    config_path = root / ".claude" / "docs" / "tasks.md"

    if not config_path.is_file():
        print(json.dumps({"error": "No .claude/docs/tasks.md found"}))
        sys.exit(1)

    cfg = parse_config(config_path.read_text())

    if cfg["storage_type"] != "markdown-files":
        print(json.dumps({"error": f"Unsupported storage type: {cfg['storage_type']}"}))
        sys.exit(1)

    tasks_dir = root / cfg["path"]
    done_dir = root / cfg["done_path"]

    # Collect tasks
    active = collect_tasks(tasks_dir, cfg)
    done = collect_tasks(done_dir, cfg, done=True)

    # Active tasks marked done also count
    done += [t for t in active if t["status"] in ("done", "completed")]
    active = [t for t in active if t["status"] not in ("done", "completed")]

    # Determine grouping
    board = cfg["board"]
    group_by = board.get("group_by", "status")

    # Determine group order from config or field values
    if "group_order" in board:
        group_order = [g.strip() for g in board["group_order"].split(",")]
    elif group_by in cfg["fields"]:
        values = cfg["fields"][group_by].get("values", [])
        group_order = [v for v in values if v not in ("done", "completed")]
    else:
        # Auto-detect from data
        seen = []
        for t in active:
            v = t.get(group_by, "")
            if v and v not in seen:
                seen.append(v)
        group_order = seen

    # Sort field
    sort_field = board.get("sort_within", "priority")

    # Group active tasks
    groups = {}
    for g in group_order:
        group_tasks = [t for t in active if t.get(group_by, "") == g]
        groups[g] = sort_tasks(group_tasks, sort_field, cfg)

    # Uncategorized
    categorized = {t["file"] for g in groups.values() for t in g}
    uncategorized = [t for t in active if t["file"] not in categorized]
    if uncategorized:
        groups["other"] = sort_tasks(uncategorized, sort_field, cfg)

    # Done recent
    done_recent_days = int(board.get("done_recent_days", 7))
    cutoff = date.today() - timedelta(days=done_recent_days)
    done_recent = []
    for t in done:
        comp = t.get("completed", "")
        if comp:
            try:
                if date.fromisoformat(comp) >= cutoff:
                    done_recent.append(t)
            except ValueError:
                pass
    done_recent.sort(key=lambda t: t.get("completed", ""), reverse=True)

    # Strip status field from output (implied by group)
    for group_tasks in groups.values():
        for t in group_tasks:
            t.pop("status", None)
    for t in done_recent:
        t.pop("status", None)

    # Build counts
    counts = {g: len(tasks) for g, tasks in groups.items()}
    counts["done_recent"] = len(done_recent)
    counts["done_total"] = len(done)

    output = {"generated": date.today().isoformat(), "counts": counts}
    output.update(groups)
    output["done_recent"] = done_recent

    print(json.dumps(output, separators=(",", ":")))


if __name__ == "__main__":
    main()
