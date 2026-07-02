require_relative "installable"

class Dotfile
  include Installable

  def initialize(filename, as: ".#{filename}")
    @source = File.join(repo_dir, filename)
    @target = File.expand_path("~/#{as}")
  end
end
