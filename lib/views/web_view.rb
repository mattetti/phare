class WebView
  
  attr_reader :application
  
  def initialize(app=nil)
    @application = app
  end

  def description 
    "Lighthouse Help" 
  end

  def render
    layout_view(:frame => [0, 0, 1020, 700], :mode => :horizontal, :layout => {:expand => [:width, :height], :start => true, :layout => :left}) do |hview|
      @web_view = web_view(:layout => {:expand =>  [:width, :height]}, :url => "http://lighthouseapp.com/help")
      hview << @web_view
    end
  end
  
end