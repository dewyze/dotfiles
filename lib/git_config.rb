require_relative "loader_config"

class GitConfig < LoaderConfig
  private

  def loader_body
    <<~INI
      [include]
      \tpath = ~/.#{@filename}.default
      \tpath = ~/.#{@filename}.local
    INI
  end
end
