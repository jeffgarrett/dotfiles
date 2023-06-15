



# OLD

## Requirements

Install
 * FiraCode Nerd Font

## Install

Install:
 * Language support:
   * cargo
 * nvim

## TODO

 * Change nvim background light/dark based on time-of-day: https://sunrise-sunset.org/api

nvim-tree
telescope
possession

  sh-shellcheck: &sh-shellcheck
    lint-command: 'shellcheck -f gcc -x'
    lint-source: 'shellcheck'
    lint-formats:
      - '%f:%l:%c: %trror: %m'
      - '%f:%l:%c: %tarning: %m'
      - '%f:%l:%c: %tote: %m'

  dockerfile-hadolint: &dockerfile-hadolint
    lint-command: 'hadolint'
    lint-formats:
      - '%f:%l %m'

  make-checkmake: &make-checkmake
    lint-command: 'checkmake'
    lint-stdin: true

  markdown-markdownlint: &markdown-markdownlint
    lint-command: 'markdownlint -s -c %USERPROFILE%\.markdownlintrc'
    lint-stdin: true
    lint-formats:
      - '%f:%l %m'
      - '%f:%l:%c %m'
      - '%f: %l: %m'

  markdown-pandoc: &markdown-pandoc
    format-command: 'pandoc -f markdown -t gfm -sp --tab-stop=2'
