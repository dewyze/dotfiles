require_relative "installable"

class ClaudeConfig
  include Installable

  def initialize(filename)
    @source = File.join(repo_dir, "claude", filename)
    @target = File.join(Dir.home, ".claude", filename)
  end
end
