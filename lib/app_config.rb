require_relative "installable"

class AppConfig
  include Installable

  def initialize(filename, app:, dir: nil)
    @source = File.join(repo_dir, filename)
    @target = File.join(Dir.home, ".config", app, *[dir].compact, filename)
  end
end
