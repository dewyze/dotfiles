task :default => "install"

namespace "configs" do
  IGNORE = %w(Rakefile README.md bin)
  SPECIAL_CONFIG = {
    "alacritty.toml" => {
      symlink: "alacritty.toml",
      dest: "~/.config/alacritty/",
    },
    "ripgreprc" => {
      symlink: "ripgreprc",
      dest: "~/.config/ripgrep/",
    },
    "init.lua" => {
      symlink: "init.lua",
      dest: "~/.config/nvim"
    },
    "Tomorrow-Night.vim" => {
      symlink: "Tomorrow-Night.vim",
      dest: "~/.config/nvim/colors"
    },
    "lua" => {
      symlink: "lua",
      dest: "~/.config/nvim/",
    },
  }

  desc "symlink files into home directory"
  task :install do
    working_dir = File.dirname(__FILE__)
    for_each_dotfile(working_dir) do |file, dotfile_path|
      convert_to_backup(dotfile_path)

      FileUtils.ln_s(file, dotfile_path)
    end
  end

  desc "remove symlinks, add old files"
  task :uninstall do
    working_dir = File.dirname(__FILE__)
    for_each_dotfile(working_dir) do |_, dotfile_path|
      FileUtils.rm_rf(dotfile_path) if File.symlink?(dotfile_path) || File.exist?(dotfile_path)

      restore_backup(dotfile_path)
    end
  end

  def for_each_dotfile(dir, &block)
    my_dotfiles = Dir.glob(File.join(dir,"*"))
    my_dotfiles.each do |file|
      filename = File.basename(file)

      next if IGNORE.include?(filename)

      config = SPECIAL_CONFIG[filename] || { dest: "~", symlink: ".#{filename}" }
      dest = File.expand_path(config[:dest])

      FileUtils.mkdir_p(dest) unless File.directory?(dest)

      dotfile_path = File.join(dest, config[:symlink])

      yield file, dotfile_path
    end
  end
end

namespace "plugins" do
  VIM_COMMAND = "nvim"

  desc "install prereqs"
  task :install  do
    puts "Installing vim plugins"

    system('nvim --headless "+Lazy! sync" +qa | tee /tmp/plug_install.txt')
  end

  desc "remove prereqs"
  task :uninstall do
    puts "Removing vim plugins"

    FileUtils.rm_rf(VIM_DIR)
    FileUtils.rm_rf(VIM_FILE)

    restore_backup(VIM_DIR)
    restore_backup(VIM_FILE)
  end
end

namespace "scripts" do
  INSTALL_DIR = File.expand_path("~/.bin")
  SCRIPT_DIR = File.expand_path(File.dirname(__FILE__))

  desc "install scripts"
  task :install do
    bin_scripts = Dir.glob(File.join(SCRIPT_DIR,"bin","*"))

    bin_scripts.each { |script| chmod( 0755, script) }

    if File.exist?(INSTALL_DIR)
      if File.symlink?(INSTALL_DIR)
        puts "WARNING: Bin symlink was present on install"
        rm(INSTALL_DIR)
      else
        puts "ERROR: Your bin folder is screwed up; can\"t install! #{INSTALL_DIR}"
        exit
      end
    end

    FileUtils.ln_s("#{SCRIPT_DIR}/bin", INSTALL_DIR)
  end

  desc "uninstall scripts"
  task :uninstall do
    if File.symlink?(INSTALL_DIR)
      rm(INSTALL_DIR)
    elsif File.exist?(INSTALL_DIR)
      puts "WARNING: Leaving a non-empty bin directory behind"
    end
  end
end


desc "install everything"
task :install => ["scripts:install", "configs:install", "plugins:install"]

desc "uninstall everything"
task :uninstall => ["plugins:uninstall", "configs:uninstall", "scripts:uninstall"]

task "all:install" => [:install]

def convert_to_backup(file)
  File.rename(file, "#{file}.bak") if File.exist?(file)
end

def restore_backup(file)
  backup_file = "#{file}.bak"
  File.rename(backup_file, file) if File.exist?(backup_file)
end
