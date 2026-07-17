require_relative "loader_config"

class ShellConfig < LoaderConfig
  def initialize(filename)
    super(filename, from: "shell")
  end

  private

  def loader_body
    <<~SH
      [ -s "$HOME/.#{@filename}.default" ] && source "$HOME/.#{@filename}.default"
      [ -s "$HOME/.#{@filename}.local" ] && source "$HOME/.#{@filename}.local"
    SH
  end
end
