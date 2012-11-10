#!/usr/bin/env ruby

  # Requires #
require 'ftools'
require 'rubygems'
require 'ruby-growl'

require './lib/tvshow'
require './lib/simplelog'

  # Constants #
TVSORTR_VERSION = "0.1"

  # Globals #
log_file = File.open(File.expand_path('~/Library/Logs/tvsortr.log'), File::CREAT | File::WRONLY | File::APPEND)
$logger = SimpleLog.new(log_file,true)

  # Functions #

def print_usage
  puts "#{__FILE__} --downloads=<path> --destination=<path>"
  exit(-1)
end

def copy_show(tvshow,destination)
  Dir.mkdir(destination) unless File.directory?(destination) unless $DRYRUN
  $logger.info "\tCopying #{tvshow.fileName} -> #{destination}/#{tvshow.fileName}"
  
  File.copy("#{TV_DOWNLOADS_DIR}/#{tvshow.fileName}",destination,false) unless $DRYRUN
  if $USE_GROWL
    $g.notify "ruby-growl Notification", 
              "TVMover: #{tvshow.name}", 
              "Season: #{tvshow.season} Episode: #{tvshow.episode}"
  end
end

  # Main #

  # Manage Options
  
  # Required:
  #  --downloads
  #  --destination
  # Optional:
  # --growl

print_usage unless ARGV.select {|a| a =~ /--downloads/ || a =~ /--destination/}.length == 2

ARGV.each do |a|
  if a =~ /--downloads=(.+)/
    TV_DOWNLOADS_DIR="#$1" 
    unless File.exists? TV_DOWNLOADS_DIR
      $logger.warning "Download Directory \'#{TV_DOWNLOADS_DIR}\' not found"
      exit -1
    end
  elsif a =~ /--destination=(.+)/
    TV_ROOT_DIR="#$1"
    unless File.exists? TV_ROOT_DIR
      $logger.error "TV Directory \'#{TV_ROOT_DIR}\' not found"
      exit -1
    end
  elsif a =~ /--growl/
    $USE_GROWL=true
  elsif a =~ /--rename/
    $RENAME=true
  elsif a =~ /--dryrun/
    $DRYRUN = true
  elsif print_usage
  end
end  

$logger.info "-----------------------------------------------------------------------"
$logger.info "Starting #{__FILE__}"
$logger.info "#{__FILE__} version #{TVSORTR_VERSION}"
$logger.info "The script running is: #{__FILE__} #{ARGV.join(" ")}"
$logger.info "logger.info File is located: #{log_file.to_s}"
$logger.info "-----------------------------------------------------------------------"

# If --growl, init ruby-growl
if $USE_GROWL 
  $g = Growl.new "localhost","ruby-growl",["ruby-growl Notification"]
end

$logger.info "Scanning TV Downloads..."
show_count = Dir.open(TV_DOWNLOADS_DIR).select { |tvshow| 
  tvshow != "." && tvshow != ".." && tvshow != ".DS_Store"}.
  each { |tvshow| new_show = TVShow.new(tvshow)
                  $logger.info "Detected: #{new_show.to_s}"
                  copy_show(new_show,"#{TV_ROOT_DIR}/#{new_show.name}")}.
                  length      
$logger.info "Summary: Copied #{show_count} shows" 
$logger.info "Exiting..."
$logger.info "-----------------------------------------------------------------------"

exit(0)
