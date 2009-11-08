require 'logger'

class SimpleLog < Logger
  attr_reader :echo_to_stdout
  
  def initialize(log_file,echo_to_stdout)
   super(log_file)
    @echo_to_stdout = echo_to_stdout
  end
  
  def info(msg)
    puts msg if echo_to_stdout
    super
  end
end  
