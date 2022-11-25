if __FILE__ == $0
  target_path = gets.chop
  target_path = target_path.chomp("/")
  Dir.glob("#{target_path}/**/*.*") do |path|
    new_lines = []
    File.open(path, "r") do |f|
      f.readlines.each do |line|
        spaces = line.match(/^\s+/)
        if spaces && spaces.to_s.size > 2
          spaces = spaces.to_s
          line = line.lstrip
          new_lines.push " "*(spaces.size/2) + line
        else
          new_lines.push line
        end
      end
    end

    parent = path.split('/')[-2]
    Dir.mkdir("outputs/#{parent}/", 755) unless Dir.exist? "outputs/#{parent}/"
    File.open("outputs/#{parent}/#{File.basename(path)}", "w") do |fo|
      new_lines.each do |l|
        fo.write l
      end
    end
  end
end