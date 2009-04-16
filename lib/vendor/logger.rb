class Logger
  
  def self.info(msg, caller=nil)
    output(msg, caller)
  end
  
  def self.debug(msg, caller=nil)
    output(msg, caller)
  end
  
  protected

  # outputs a message to the logs and display the stack trace
  # if the caller is passed
  def self.output(msg, caller=nil)
    NSLog(msg)
    if caller
      NSLog("stack trace:\n***\n")
      NSLog(caller.join("\n"))
      NSLog("\n***\n")
    end
  end
  
end