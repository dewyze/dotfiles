require_relative "loader_config"

class GitConfig < LoaderConfig
  def initialize(filename)
    super(filename, from: "git")
  end

  private

  def loader_body
    <<~INI
      [include]
      \tpath = ~/.#{@filename}.default
      \tpath = ~/.#{@filename}.local
    INI
  end
end
