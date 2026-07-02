require_relative "installable"

class ShellConfig
  include Installable

  def initialize(filename)
    @filename = filename
    @source = File.join(repo_dir, "#{filename}.default")
    @target = File.expand_path("~/.#{filename}.default")
    @loader_path = File.expand_path("~/.#{filename}")
  end

  def install
    super
    create_loader
  end

  private

  def create_loader
    return if File.exist?(@loader_path)

    File.write(@loader_path, loader_content)
  end

  def loader_content
    <<~SH
      # .#{@filename} — thin loader
      # Tool-managed lines (homebrew, mise, rustup, etc.) can be added below.

      [ -s "$HOME/.#{@filename}.default" ] && source "$HOME/.#{@filename}.default"
      [ -s "$HOME/.#{@filename}.local" ] && source "$HOME/.#{@filename}.local"
    SH
  end
end
