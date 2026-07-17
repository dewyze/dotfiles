require_relative "installable"

class Dotfile
  include Installable

  def initialize(filename, as: ".#{filename}", from: nil)
    @source = File.join(repo_dir, *[from].compact, filename)
    @target = File.expand_path("~/#{as}")
  end
end
