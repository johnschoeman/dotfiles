{ pkgs, ... }:
{
    home.packages = [
        pkgs.helix
    ];

    programs.helix = {
        enable = true;
        defaultEditor = true;
        settings = {
            editor = {
                line-number = "relative";
                lsp.display-messages = true;
                bufferline = "multiple";
            };
            keys.normal = {
                space.space = "file_picker";
                space.w = ":w";
                space.q = ":q";
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
    };
}
