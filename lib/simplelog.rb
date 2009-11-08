require 'logger'

class SimpleLog < Logger
  attr_reader :echo_to_stdout
  
  def initialize(log_file,echo_to_stdout)
   super(log_file)
    @echo_to_stdout = echo_to_stdout
  end
  
  def info(msg)
    puts "INFO:\t#{msg}" if echo_to_stdout
    super
  end
  
  def warning(msg)
    puts "WARNING:\t#{msg}" if echo_to_stdout
    super
  end
  
  def error(msg)
    puts "ERROR:\t#{msg}" if echo_to_stdout
    super
  end
end  
