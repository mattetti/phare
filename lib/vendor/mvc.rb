require 'hotcocoa'
include HotCocoa

class HotCocoaApplication
  
  attr_reader :views, :current_view, :main_window, :segments
  
  def initialize
    load_models
    load_controllers
    load_views
    # the start method should be befined in the HotCocoaApplication instance
    start
  end
  
  # Add a view to the list of available views
  def register_view(view_class, description)
    Logger.debug("registering #{view_class}")
    @views ||= []
    @views << {:klass => view_class, :description => description} unless @views.find{|v| v[:klass] == view_class}
  end
  
  # Returns the matching view
  def find_view(klass)
    Logger.debug("available view classes: #{views.inspect}")
    Logger.debug("looking for #{klass}")
    view = @views.find {|view| view[:klass] == klass}
    unless view
      Logger.info("HotCocoa couldn't find a view with a description defined as: '#{description}'")
      Logger.info("stack trace:\n***\n")
      Logger.info(caller.join("\n"))
      Logger.info("\n***\n")
    else
      # returns the constantized version of the string
      Object.const_get(view[:klass])
    end
  end
  
  # helper to add a segment control to a window
  #
  # === Usage
  #    win << segment_control
  #
  def segment_control
    @segment_control ||= create_segment_control
  end
  
  # file/open
  def on_open(menu)
  end
  
  # file/new 
  def on_new(menu)
  end
  
  # help menu item
  def on_help(menu)
  end
  
  # This is commented out, so the minimize menu item is disabled
  #def on_minimize(menu)
  #end
  
  # window/zoom
  def on_zoom(menu)
  end
  
  # window/bring_all_to_front
  def on_bring_all_to_front(menu)
  end
  
  # Render a view in the main window
  def display(view_name)
    main_window.view.remove(current_view) if current_view
    Logger.info("Loading #{view_name}")
    view_to_display = find_view(view_name)
    @current_view = view_to_display.new(self).render
    Logger.info("current_view #{@current_view.inspect}")
    main_window << @current_view
  end
  
  protected

    def create_segment_control
      segmented_control(:layout => {:expand => :width, :align => :center, :start => false}, :segments => segments) do |seg|
        seg.on_action do
          view_to_use = views.find{|v| v[:description] == @segment_control.selected_segment.label}
          display(view_to_use[:klass]) if view_to_use
        end 
      end
    end
    
    # Set the segments to be use by the segmented control
    # view class descriptions are used as labels
    def segments
      @segments ||= @views.collect {|view_class| {:label => view_class[:description], :width => 0}}
    end
    
    def load_controllers
      Dir.glob(File.join(File.dirname(__FILE__), '..', 'controllers', '*controller.rb')).each do |file|
        require file
      end
    end

    def load_views
      Dir.glob(File.join(File.dirname(__FILE__), '..', 'views', '*view.rb')).each do |file|
        require file
        klass = File.basename(file).gsub(/\.rb$/, '').camel_case
        register_view(klass, Object.const_get(klass).new.description)
      end
    end
    
    def load_models
      Dir.glob(File.join(File.dirname(__FILE__), '..', 'models', '*.rb')).each do |file|
        require file
      end
    end
  
end