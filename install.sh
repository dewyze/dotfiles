rake

if [ -f /etc/spin/secrets/copilot_hosts.json ]; then
  mkdir -p "${HOME}/.config/github-copilot"
  ln -s github_copilot_terms.json "${HOME}/.config/github-copilot/github_copilot_terms.json"
  cp /etc/spin/secrets/copilot_hosts.json "${HOME}/.config/github-copilot/hosts.json"
fi
