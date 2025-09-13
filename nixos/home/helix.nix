{ pkgs, ... }:
{
    home.packages = [
        pkgs.helix
    ];

    programs.helix = {
        enable = true;
        defaultEditor = true;
        settings = {
            theme = "everforest_dark";
            editor = {
                line-number = "relative";
                lsp.display-messages = true;
                lsp.display-inlay-hints = true;
                inline-diagnostics.cursor-line = "hint";
                bufferline = "multiple";
                cursorline = true;
            };
            keys.normal = {
                space.space = "file_picker";
                space.w = ":w";
                space.q = ":q";
                space.o = "file_picker_in_current_buffer_directory";
                esc = ["collapse_selection" "keep_primary_selection"];
            };
            keys.normal.z = {
                j = "page_down";
                k = "page_up";
            };
            keys.insert = {
                j = { k = "normal_mode"; };
            };

        };
        languages = {
            language = [{
                name = "rust";
                auto-format = false;
            }];
            language-server.rust-analyzer = {
                 config = { procMacro = { ignored = { leptos_macro = [ "component" "server" ]; }; }; };
            };
            language-server.rust-analyzer.config.cargo = {
                 allFeatures = true;
            };
        };
    };
}
