task :default => :setup

IGNORE = %w(Rakefile README.md Tomorrow-Night.vim)

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
