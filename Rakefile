require_relative "lib/dotfile"
require_relative "lib/app_config"
require_relative "lib/claude_config"
require_relative "lib/shell_config"
require_relative "lib/git_config"
require_relative "lib/bin_file"

CONFIGS = [
  GitConfig.new("gitconfig"),
  Dotfile.new("gitignore_global", from: "git"),

  Dotfile.new("tmux.conf",     from: "tmux"),
  Dotfile.new("tmuxline.conf", from: "tmux"),

  Dotfile.new("git_prompt",     from: "shell"),
  Dotfile.new("aliases_shared", from: "shell"),
  ShellConfig.new("zshenv"),
  ShellConfig.new("zshrc"),

  Dotfile.new("nvim", as: ".config/nvim"),

  AppConfig.new("alacritty.toml", app: "alacritty"),
  AppConfig.new("ripgreprc",      app: "ripgrep"),

  ClaudeConfig.new("CLAUDE.md"),
  ClaudeConfig.new("commands"),
  ClaudeConfig.new("skills"),

  BinFile.new("diff-highlight"),
].freeze

task default: :install

desc "Install configs, scripts, and plugins"
task :install do
  CONFIGS.each(&:install)
  Rake::Task["plugins:install"].invoke
end

desc "Uninstall configs and scripts"
task :uninstall do
  CONFIGS.reverse_each(&:uninstall)
end

namespace :plugins do
  desc "Install vim plugins at the locked versions"
  task :install do
    system('nvim --headless "+Lazy! restore" +qa')
  end

  desc "Update vim plugins and rewrite the lockfile"
  task :update do
    system('nvim --headless "+Lazy! update" +qa')
  end
end
