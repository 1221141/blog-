require 'front_matter_parser'

dir_path = "./blog"
unsafe_loader = ->(string) { YAML.load(string) }
# file_contents = File.read('./blog/2023_04_29_10_04_18_obsidian-file-creation-renamed-with-templater.md')
# parsed = FrontMatterParser::Parser.new(:md,loader: unsafe_loader).call(file_contents)

File.open("README.md", "w") do |file|
  file.write("# Index\n\n")
  file.write("Here are the blog entries in reverse order\n\n")
  Dir.entries(dir_path).each do |file_name|
    next if file_name == '.' || file_name == '..' || file_name == 'assets' # skip current and parent directory links
    
    file_contents = File.read("#{dir_path}/#{file_name}")
    parsed = FrontMatterParser::Parser.new(:md, loader: unsafe_loader).call(file_contents)
    file.write"[#{parsed.front_matter['Created']} - #{parsed.front_matter['Title']}](#{dir_path}/#{file_name})\n"
  end
end
