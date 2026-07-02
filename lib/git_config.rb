require_relative "installable"

class GitConfig
  include Installable

  def initialize(filename)
    @filename = filename
    @source = File.join(repo_dir, filename)
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
    <<~INI
      # .#{@filename} — thin loader
      # Tool-written config (git config --global ...) can be added below.
      [include]
      \tpath = ~/.#{@filename}.default
      \tpath = ~/.#{@filename}.local
    INI
  end
end
