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
    `rdoc --exclude tests/`
end

desc "This executes a sample run with the files in tests/helpers"
task :run do
 puts `ruby tvsortr.rb --downloads=example/Downloads --destination=example/TV`
end

desc "cleans files from unit tests and dry run"
task :clean do
  #Recreate the Downloads directory
  Dir.rmdir EXAMPLE_DOWNLOADS if File.exists? EXAMPLE_DOWNLOADS

  EXAMPLE_FILES.each { |show| File.touch "#{EXAMPLE_DOWNLOADS/show}" }
  
  #Recreate the TV direcory
  Dir.rmdir EXAMPLE_TV if File.exists? EXAMPLE_TV
  Dir.mkdir EXAMPLE_TV
end 


