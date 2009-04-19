class ProjectSelectionView < HotCocoaView
  
  def description 
    "Project Selection" 
  end

  def render
    layout_view(:frame => [0, 0, 0, 400], :mode => :horizontal, :layout => {:expand => :width, :start => false, :layout => :left}) do |hview|
       @web_view = web_view(:layout => {:expand =>  [:width, :height]}, :url => "http://merbist.com")
       hview << @web_view
     end
  end

end