# deploy

Project-specific deployment procedures and pre-deploy checks.

## Recommends when

Project has a deployment target — cloud services, servers, containers, static hosting, or even local system rebuilds (e.g., NixOS). Useful when deployment requires specific steps, checks, or environment considerations.

## Detection hints

- `Dockerfile` or `docker-compose.yml` exists
- `.github/workflows/` with deploy jobs
- `vercel.json`, `netlify.toml`, or similar hosting config
- `Makefile` with deploy target
- `nixos/` with rebuild commands (NixOS systems)
- `fly.toml`, `render.yaml`, `railway.json`

## Questions

1. **deploy_target** — Where does this project deploy?
   - `custom` — Ask user to describe their deployment target and process
   - No default — this is always project-specific

2. **pre_deploy_checks** — What should be verified before deploying?
   - `standard` — Run tests, check for uncommitted changes, verify branch (default)
   - `with-build` — Standard plus build/compile step
   - `with-lint` — Standard plus linting and type checking
   - `minimal` — Just check for uncommitted changes
   - `custom` — Ask user to describe

3. **deploy_command** — What command triggers deployment?
   - `custom` — Ask user for the command(s)
   - No default — this is always project-specific

4. **rollback** — Is there a rollback procedure?
   - `none` — No formal rollback (default)
   - `manual` — Document manual rollback steps (ask user to describe)
   - `automated` — There's a rollback command (ask for it)

5. **environments** — Are there multiple deployment environments?
   - `single` — Just production (default)
   - `staging-prod` — Staging then production
   - `multi` — Multiple environments (ask user to list them)

## Generated files

- `SKILL.md` — from `SKILL.md.template`
