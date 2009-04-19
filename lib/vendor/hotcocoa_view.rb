class HotCocoaView
  attr_reader :application
  
  def initialize(app=nil)
    @application = app
  end

  def description 
    "" 
  end
  
end