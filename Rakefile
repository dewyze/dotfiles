task :default => :setup

desc 'symlink files into home directory'
task :setup do
  home_dir = File.expand_path("~/dev/sandbox/")
  working_dir = File.expand_path(File.dirname(__FILE__))
  my_dotfiles = Dir.glob(File.join(working_dir,"*"))

  my_dotfiles.each do |file|
    filename = File.basename(file)
    full_name = File.expand_path(file)
    old_dotfile = File.join(home_dir,".#{filename}")

    next if filename =~ /Rakefile/ || filename =~ /README\.md$/

    if File.exist?(old_dotfile)
      File.rename(old_dotfile, "#{old_dotfile}.jd.bak")
    end

    sym_link = File.join(working_dir,"#{filename}")

    ln_s sym_link, old_dotfile
  end
end

desc 'remove symlinks, add old files'
task :teardown do
  home_dir = File.expand_path("~/dev/sandbox/")
  working_dir = File.expand_path(File.dirname(__FILE__))
  my_dotfiles = Dir.glob(File.join(working_dir,"*"))

  my_dotfiles.each do |file|
    filename = File.basename(file)
    full_name = File.expand_path(file)
    dotfile = File.join(home_dir,".#{filename}")

    next if filename =~ /Rakefile/ || filename =~ /README\.txt$/


    rm_rf(dotfile) if File.symlink?(dotfile) || File.exist?(dotfile)

    old_dotfile = File.join(home_dir,".#{filename}.jd.bak")
    if File.exist?(old_dotfile)
      File.rename(old_dotfile,dotfile)
    end
  end
end
