task :default => :setup

IGNORE = %w(Rakefile README.md Tomorrow-Night.vim)

PREREQ_REPOSITORIES = {
  "Vundler" => {
    :type => :git,
    :uri => "https://github.com/VundleVim/Vundle.vim.git",
    :install_dir => "~/.vim/bundle/Vundle.vim",
    :commands => {
      :post_install => ["vim +PluginInstall +qall"]
    }
  }
}


task :install do
  Rake::Task["setup"].invoke
  Rake::Task["prepare"].invoke
end

task :uninstall do
  Rake::Task["unprepare"].invoke
  Rake::Task["teardown"].invoke
end


desc 'install prereqs'
task :prepare do
  PREREQ_REPOSITORIES.each do |name, config|
    puts "Installing #{name}"

    if config[:type] == :git && config[:install_dir]
      parent_dir = File.dirname(config[:install_dir])
      rm_rf(File.expand_path(config[:install_dir]))
      mkdir_p(parent_dir) unless File.exist?(parent_dir)
      system("git clone #{config[:uri]} #{config[:install_dir]}")
    end

    if config[:commands] && config[:commands][:post_install]
      config[:commands][:post_install].each { |command| system(command) }
    end
  end
end

desc 'remove prereqs'
task :unprepare do
  PREREQ_REPOSITORIES.each do |name, config|
    puts "Uninstalling #{name}"
    if config[:type] == :git
      install_dir = File.expand_path(config[:install_dir])
      rm_rf(install_dir) if config[:install_dir] && File.directory?(install_dir)
    end
  end
end


desc 'symlink files into home directory'
task :setup do
  home_dir = File.expand_path("~")
  dotfiles_dir = File.expand_path(File.dirname(__FILE__))
  my_dotfiles = Dir.glob(File.join(dotfiles_dir,"*"))

  my_dotfiles.each do |file|
    filename = File.basename(file)
    old_dotfile = File.join(home_dir,".#{filename}")

    next if IGNORE.include?(filename)

    if File.exist?(old_dotfile)
      File.rename(old_dotfile, "#{old_dotfile}.jd.bak")
    end

    sym_link = File.join(dotfiles_dir,"#{filename}")

    ln_s sym_link, old_dotfile
  end
end

desc 'remove symlinks, add old files'
task :teardown do
  home_dir = File.expand_path("~")
  dotfiles_dir = File.expand_path(File.dirname(__FILE__))
  my_dotfiles = Dir.glob(File.join(dotfiles_dir,"*"))

  my_dotfiles.each do |file|
    filename = File.basename(file)
    dotfile = File.join(home_dir,".#{filename}")

    next if IGNORE.include?(filename)

    rm_rf(dotfile) if File.symlink?(dotfile) || File.exist?(dotfile)

    old_dotfile = File.join(home_dir,".#{filename}.jd.bak")
    if File.exist?(old_dotfile)
      File.rename(old_dotfile,dotfile)
    end
  end
end
