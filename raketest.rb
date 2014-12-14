  working_dir = File.expand_path(File.dirname(__FILE__))
  # home_dir = File.expand_path("~")
  home_dir = File.expand_path("~/dev/sandbox/")
  my_dotfiles = Dir.glob(File.join(working_dir,"*"))
  old_dotfiles = Dir.glob(File.join(home_dir,".*"))

  old_dotfiles.each do |file|
    filename = File.basename(file)
    unless filename == "." || filename == ".."
      File.rename(File.basename(filename),"#{filename}.jd.bak")
    end
  end

  backup_files = Dir.glob(File.join(home_dir,".*.jd.bak"))

  backup_files.each do |file|
    filename = File.basename(file)
    original_name = filename.split(".jd.bak").first
    File.rename(File.basename(filename),original_name)
    puts "filename: #{filename}"
  end

  # my_dotfiles.each do |filename|
  #   next if filename =~ /Rakefile/ || filename =~ /README\.txt$/

  #   sym_link = File.join(home_dir,".#{File.basename(filename)}")

  #   rm_rf(sym_link) if File.symlink?(sym_link) || File.exist?(sym_link)
  #   ln_s filename, sym_link
  # end
