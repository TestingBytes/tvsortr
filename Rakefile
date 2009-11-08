require 'fileutils'

EXAMPLE_TV = "example/TV"
EXAMPLE_DOWNLOADS = "example/Downloads"

EXAMPLE_FILES = [
"The.Sampsons.S01E03.The.One.About.Bacon.avi",  
"The.Sampsons.S01E05.The-Octoberfest-Special.avi",
"The.Sampsons.S02E08.Dead Men Dont Wear Plaid.avi", 
"That.Daily.Show.2009.10.12.avi",
"That.Daily.Show.2009.10.15.avi",
"That.Daily.Show.2009.10.19.avi",
]

desc "This runs all unit tests"
task :test do
  
end

desc "This runs rdoc with appropriate excludes"
task :doc do
  puts `rdoc --exclude tests/`
end

desc "This executes a sample run with the files in tests/helpers"
task :run do
  puts `ruby tvsortr.rb --downloads=example/Downloads --destination=example/TV`
end

desc "cleans files from unit tests and dry run"
task :clean do
  #Recreate the Downloads directory  
  `rm -rf example`
  
  Dir.mkdir "example"
  Dir.mkdir EXAMPLE_DOWNLOADS
  
  EXAMPLE_FILES.each { |show| File.new("#{EXAMPLE_DOWNLOADS}/#{show}", File::CREAT) }
  
  `rm -rf #{EXAMPLE_TV}`  
  Dir.mkdir EXAMPLE_TV
end 


