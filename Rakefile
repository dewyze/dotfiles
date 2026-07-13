require_relative "lib/dotfile"
require_relative "lib/app_config"
require_relative "lib/shell_config"
require_relative "lib/git_config"
require_relative "lib/bin_file"

CONFIGS = [
  GitConfig.new("gitconfig"),
  Dotfile.new("gitignore_global"),
  Dotfile.new("tmux.conf"),
  Dotfile.new("tmuxline.conf"),
  Dotfile.new("git_prompt"),
  Dotfile.new("aliases_shared"),

  AppConfig.new("alacritty.toml", app: "alacritty"),
  AppConfig.new("ripgreprc",      app: "ripgrep"),
  AppConfig.new("init.lua",       app: "nvim"),
  AppConfig.new("lua",            app: "nvim"),
  AppConfig.new("after",          app: "nvim"),
  AppConfig.new("Tomorrow-Night.vim", app: "nvim", dir: "colors"),

  ShellConfig.new("zshenv"),
  ShellConfig.new("zshrc"),

  BinFile.new("diff-highlight"),
].freeze

task default: :install

desc "Install configs, scripts, and plugins"
task install: "plugins:install" do
  CONFIGS.each(&:install)
end

desc "Uninstall configs and scripts"
task :uninstall do
  CONFIGS.reverse_each(&:uninstall)
end

namespace :plugins do
  desc "Install vim plugins"
  task :install do
    system('nvim --headless "+Lazy! sync" +qa')
  end
end
