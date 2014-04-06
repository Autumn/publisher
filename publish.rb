require 'nokogiri'

def inject(filename, template, content)

  file = open filename, "w+"
  doc = Nokogiri::HTML(open(template))
  doc.css("#content")[0].content = content

  file.write "#{doc}"

end

if ARGV[0] == "publish"

  abort("need a file") if ARGV[1] == nil
  contents = File.open(ARGV[1]).readlines.join
  title = File.basename(ARGV[1], File.extname(ARGV[1]))

  t = Time.now
  filename = "#{t.year}-#{t.month}-#{t.day}-#{title}.html"
  inject filename, "templates/base", contents

  system "echo '- [#{t.year}-#{t.month}-#{t.day} - title ](#{filename})' | cat - templates/contents > tmp && mv tmp templates/contents"  
  system "ruby publish.rb build"

  puts "wrote #{filename}"

elsif ARGV[0] == "build"

  config = open("config")
  rules = config.readlines
  rules.each do |rule|
    pair = rule.split(":")
    inject pair[0], "templates/base", open(pair[1].chomp).readlines.join
  end 

elsif ARGV[0] == "link"

  abort("need a link") if ARGV[1] == nil
  abort("need a description") if ARGV[2] == nil
  
  if ARGV[3] != nil
    system "echo '-- #{ARGV[3]}' | cat - templates/links > tmp && mv tmp templates/links"
  end

  system "echo '- [#{ARGV[2]}](#{ARGV[1]})' | cat - templates/links > tmp && mv tmp templates/links"  
  system "ruby publish.rb build"

else

   puts "publisher - dead simple website generator"
   puts
   puts "build - builds pages listed in the config file"
   puts "publish file - adds file to the site"
   puts "link url description commentary? - add a link"
end
