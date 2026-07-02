require_relative "loader_config"

class ShellConfig < LoaderConfig
  private

  def loader_body
    <<~SH
      [ -s "$HOME/.#{@filename}.default" ] && source "$HOME/.#{@filename}.default"
      [ -s "$HOME/.#{@filename}.local" ] && source "$HOME/.#{@filename}.local"
    SH
  end
end
