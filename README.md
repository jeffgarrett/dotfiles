# dotfiles

## Requirements

Python with venv

On Debian/Ubuntu, sudo apt install python3-venv

## Initial setup

1. Clone this repository to ~/.dotfiles
2. Create a virtual environment:
   ```sh
   export DOTFILES=~/.dotfiles
   export DOTFILES_VENV=${DOTFILES}/env
   export ANSIBLE_CONFIG=${DOTFILES}/ansible.cfg

   python3 -m venv ${DOTFILES_VENV}
   source ${DOTFILES_VENV}/bin/activate
   pip install -r ${DOTFILES}/requirements.txt
   ```
3. Create an inventory file:
   ```sh
   # Edit as necessary
   cp ${DOTFILES}/inventory-template.yaml ${DOTFILES}/inventory.yaml
   ``` 
4. Run ansible to check first
   ```sh
   ansible-playbook --check --diff ansible/playbooks/install.yaml
   ```
5. Run ansible
   ```
   ansible-playbook ansible/playbooks/install.yaml
   ```
