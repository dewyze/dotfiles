require "fileutils"

module Installable
  def install
    prepare
    make_directory
    symlink
  end

  def uninstall
    remove
    restore
  end

  private

  def repo_dir
    File.expand_path("..", __dir__)
  end

  def prepare
    if File.symlink?(@target)
      FileUtils.rm(@target)
    elsif File.exist?(@target)
      File.rename(@target, backup_path)
    end
  end

  def make_directory
    FileUtils.mkdir_p(File.dirname(@target))
  end

  def symlink
    FileUtils.ln_s(@source, @target)
  end

  def remove
    FileUtils.rm(@target) if File.symlink?(@target)
  end

  def restore
    File.rename(backup_path, @target) if File.exist?(backup_path)
  end

  def backup_path
    "#{@target}.bak"
  end
end
