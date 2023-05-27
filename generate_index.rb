require 'front_matter_parser'

dir_path = "./blog"

unsafe_loader = ->(string) { YAML.load(string) }

Entry = Struct.new(:title, :created, :filename)

entries = []

Dir.entries(dir_path).each do |file_name|
  next if file_name == '.' || file_name == '..' || file_name == 'assets' # skip current and parent directory links

  file_contents = File.read("#{dir_path}/#{file_name}")
  parsed = FrontMatterParser::Parser.new(:md, loader: unsafe_loader).call(file_contents)
  entries.push(Entry.new(parsed.front_matter['Title'] || parsed.front_matter['title'], parsed.front_matter['Created'] || parsed.front_matter['created'], "#{dir_path}/#{file_name}"))
end

sorted_entries = entries.sort_by { |entry| entry.filename }.reverse


File.open("README.md", "w") do |file|
  file.write("# Index\n\n")

  sorted_entries.each do |entry|
  file.write"- [`#{entry.created} - #{entry.title}`](#{entry.filename})\n"
  end
end
