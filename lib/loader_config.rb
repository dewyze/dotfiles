require_relative "installable"

# Base for configs whose target file is also written to by other tools
# (shells, git). The repo owns a .default that gets symlinked; a thin
# loader lives in $HOME and pulls in .default and .local. We only manage
# a fenced block inside that loader, so tool-added lines outside the
# fence survive install and uninstall.
class LoaderConfig
  include Installable

  FENCE_BEGIN = "# BEGIN DOTFILES MANAGED BLOCK".freeze
  FENCE_END = "# END DOTFILES MANAGED BLOCK".freeze

  def initialize(filename, from: nil)
    @filename = filename
    @source = File.join(repo_dir, *[from].compact, "#{filename}.default")
    @target = File.expand_path("~/.#{filename}.default")
    @loader_path = File.expand_path("~/.#{filename}")
  end

  def install
    super
    write_loader(with_managed_block(loader_without_block))
  end

  def uninstall
    super
    write_loader(loader_without_block) if File.exist?(@loader_path)
  end

  private

  # Subclasses provide the lines that go inside the fence.
  def loader_body
    raise NotImplementedError
  end

  def with_managed_block(content)
    "#{FENCE_BEGIN}\n#{loader_body.chomp}\n#{FENCE_END}\n#{content}"
  end

  def loader_without_block
    return "" unless File.exist?(@loader_path)

    File.read(@loader_path).sub(/#{Regexp.escape(FENCE_BEGIN)}.*?#{Regexp.escape(FENCE_END)}\n?/m, "")
  end

  def write_loader(content)
    File.write(@loader_path, content)
  end
end
