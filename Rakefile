task :default => :setup

desc 'symlink files into home directory'
task :setup do
  working_dir = File.expand_path(File.dirname(__FILE__))
  my_dotfiles = Dir.glob(File.join(working_dir,"*"))
  dotfile_basenames = my_dotfiles.map { |file| ".#{File.basename(file)}" }

  home_dir = File.expand_path("~/dev/sandbox/")
  old_dotfiles = Dir.glob(File.join(home_dir,".*"))

  old_dotfiles.each do |file|
    filename = File.basename(file)
    full_filename = File.expand_path(file)
    unless filename == "." || filename == ".."
      if dotfile_basenames.include?(filename)
        File.rename("#{full_filename}","#{full_filename}.jd.bak")
      end
    end
  end

  # my_dotfiles.each do |filename|
  #   next if filename =~ /Rakefile/ || filename =~ /README\.md$/

  #   sym_link = File.join(home_dir,".#{File.basename(filename)}")

  #   rm_rf(sym_link) if File.symlink?(sym_link) || File.exist?(sym_link)
  #   ln_s filename, sym_link
  # end
end

desc 'remove symlinks, add old files'
task :teardown do
  working_dir = File.expand_path(File.dirname(__FILE__))
  my_dotfiles = Dir.glob(File.join(working_dir,"*"))

  home_dir = File.expand_path("~/dev/sandbox/")
  old_dotfiles = Dir.glob(File.join(home_dir,".*.jd.bak"))

  # my_dotfiles.each do |filename|
  #   next if filename =~ /Rakefile/ || filename =~ /README\.txt$/

  #   sym_link = File.join(home_dir,".#{File.basename(filename)}")

  #   rm_rf(sym_link) if File.symlink?(sym_link) || File.exist?(sym_link)
  #   ln_s filename, sym_link
  # end

  old_dotfiles.each do |file|
    filename = File.basename(file)
    full_name = File.expand_path(file)
    dir = File.dirname(file)
    original_name = filename.split(".jd.bak").first
    File.rename(full_name,File.join(dir,original_name))
    puts "filename: #{filename}"
  end
end
