dotfiles
-----------

These dotfiles were started with a clone from thoughtbot's dotfiles:

[thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles)

Requirements
------------

zsh must be your login shell:

```bash
chsh -s $(which zsh)
```

Install
-------

1. Clone onto your laptop:

```bash
git clone git://github.com/johnschoeman/dotfiles.git ~/dotfiles
```

2. Run the setup script:

```bash
bash ~/dotfiles/setup_dotfiles.sh
```

This will

- Set zsh as the login shell
- Install programs (Assuming brew is installed)
- Make symlinks for relevant rc files.
- Install vim-plug 


What's in it?
-------------

[vim](http://www.vim.org/) configuration:

* [Ctrl-P](https://github.com/ctrlpvim/ctrlp.vim) for fuzzy file/buffer/tag finding.
* Set `<leader>` to a single space.

[ack](https://beyondgrep.com/) for grepping.

[tmux](http://robots.thoughtbot.com/a-tmux-crash-course)
configuration:

* Improve color resolution.
* Remove administrative debris (session name, hostname, time) in status bar.
* Set prefix to `Ctrl+s`
* Soften status bar color from harsh green to light gray.

[git](http://git-scm.com/) configuration:

Shell aliases and scripts:

* `g` with no arguments is `git status` and with arguments acts like `git`.


Thank you, [contributors](https://github.com/thoughtbot/dotfiles/contributors)
Also, thank you to Corey Haines, Gary Bernhardt, Chris Toomey, and others for
sharing your dotfiles and other shell scripts from which we derived inspiration
for items in this project.
