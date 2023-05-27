# dotfiles

## Requirements

Python with venv

On Debian/Ubuntu, sudo apt install python3-venv

## Initial setup

1. Clone this repository to ~/.dotfiles
2. Create a virtual environment:
  1. python3 -m venv ~/.dotfiles/env
  2. source ~/.dotfiles/env/bin/activate
  3. pip install -r ~/.dotfiles/requirements.txt
  4. `export ANSIBLE_CONFIG=~/.dotfiles/ansible.cfg`
3. Create an inventory file:



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
