require_relative "installable"

# Sources mirror the install target: config/<app>/<file> → ~/.config/<app>/<file>
class AppConfig
  include Installable

  def initialize(filename, app:, dir: nil)
    @source = File.join(repo_dir, "config", app, *[dir].compact, filename)
    @target = File.join(Dir.home, ".config", app, *[dir].compact, filename)
  end
end
