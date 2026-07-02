require_relative "installable"

class BinFile
  include Installable

  def initialize(filename)
    @source = File.join(repo_dir, "bin", filename)
    @target = File.expand_path("~/.bin/#{filename}")
  end

  def install
    make_executable
    super
  end

  private

  def make_executable
    FileUtils.chmod(0755, @source)
  end
end
