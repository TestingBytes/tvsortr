#!/usr/bin/env ruby

# tvsortr.rb Version 0.1
# Author: Sam Johnson (samuel.johnson@gmail.com)
# Date: November 5, 2009
# 
# Description: This script takes a folder of downloaded TV shows and copies them
#   into XBMC friendly directory tree
#   
# Example: ruby tvsortr.rb --downloads=Downloads --destination=TV
#   ../Downloads/American.Dad.S05E03.avi is copied to ../TV/American Dad/American.Dad.S05E03.avi
#   
# Flags:
#   --downloads=s       The path to your downloaded TV shows
#   --destination=s     The path to your XBMC TV media Path
#   --growl             Creates growl notifcation popups for each file detected/copied
#   
# Notes:
#   - Logs are saved to "~/Library/Logs/tvsortr.log"
#   - Currently detects only 2 naming conventions:
#       Episodic Shows: {Period.delimited.show.name}.S{number}E{number}.*
#       Daily Shows:    {Period.delimited.show.name}.{YYYY}.{MM}.{DD}.*
# 
# TODO:
#   - add 'move' flag
#   - Detect platform, and disable growl on windows
#   - Add /S\d{2}xE\d{2}/ naming convention for Episodic shows
#   - Add rename option to transfer A.TV.Show.S03E21.blah.HDTV.[someCrew].avi to A.TV.Show.S03E21.avi
#   - Modify class TVShow to inherit from File. This would simplify copying and scrubbing the name

  # Requires #
require 'ftools'
require 'rubygems'
require 'ruby-growl'

require 'tvsortr/lib/tvshow'
require 'tvsortr/lib/simplelog'

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
  Dir.mkdir(destination) unless File.directory?(destination)
  $logger.info "\tCopying #{tvshow.fileName} -> #{destination}/#{tvshow.fileName}"
  
  File.copy("#{TV_DOWNLOADS_DIR}/#{tvshow.fileName}",destination,false)  
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

# Don't run with Unit Tests
if $0 != __FILE__
  exit(0)
end

print_usage unless ARGV.select {|a| a =~ /--downloads/ || a =~ /--destination/}.length == 2

ARGV.each do |a|
  if a =~ /--downloads=(.+)/
    TV_DOWNLOADS_DIR="#$1"
  elsif a =~ /--destination=(.+)/
    TV_ROOT_DIR="#$1"
  elsif a =~ /--growl/
    $USE_GROWL=true
  elsif a =~ /--rename/
    $RENAME=true
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