sudo apt-get install -y neovim
rake

if [[ -v SPIN ]]; then
  if [ -f /etc/spin/secrets/copilot_hosts.json ]; then
    mkdir -p "${HOME}/.config/github-copilot"
    ln -s github_copilot_terms.json "${HOME}/.config/github-copilot/terms.json"
    cp /etc/spin/secrets/copilot_hosts.json "${HOME}/.config/github-copilot/hosts.json"
  fi
fi
