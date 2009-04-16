class AccountSetupView
  include AccountSetupController
  attr_reader :application
  
  def initialize(app=nil)
    @application = app
  end
  
  def description 
    "Lighthouse Account Settings" 
  end

  def render
    layout_view(:frame => [0, 0, 0, 0], :layout => {:expand => [:width, :height]}) do |layout|
      # API TOKEN
      layout << layout_view(:frame => [0, 0, 0, 60], :mode => :horizontal, :layout => {:expand => :width, :start => false, :layout => :left}) do |hview|
        hview << label(:text => "Your API Token:",      :frame => [0,0,110,25],     :layout => {:align => :left, :left_padding => 200})
        hview << @api_token = text_field(:text => (application.api_token || ''),   :frame => [0,0,315,25],     :layout => {:align => :left, :right_padding => 10})
        hview << button(:title => "Save Token",  :frame => [0, 0, 170, 30],  :layout => {:align => :left}, :bezel => :regular_square, :on_action => save_api_key)
        hview << @save_label = label(:text => '', :layout => {:align => :left}, :frame => [0,0,110,25])
      end
    
      layout << layout_view(:frame => [0, 0, 50, 30], :mode => :horizontal, :layout => {:expand => :width, :start => false}) do |hview|
        hview << combox_box_view
      end
    
      # Add an account
      layout << layout_view(:frame => [0, 0, 0, 60], :mode => :horizontal, :layout => {:expand => :width, :start => false, :layout => :left}) do |hview|
        hview << label(:text => "Account Name:",      :frame => [0,0,110,25],     :layout => {:align => :left, :left_padding => 200})
        hview << @new_account_name = text_field(:text => '',   :frame => [0,0,115,25],     :layout => {:align => :left, :left_padding => -10})
        hview << label(:text => '.lighthouseapp.com', :layout => {:align => :left, :left_padding => -10}, :frame => [0,0,120,25])
        hview << button(:title => "Add",  :frame => [0, 0, 70, 30],  :layout => {:align => :left, :left_padding => 20}, :bezel => :regular_square, :on_action => add_project)
        hview << @add_account_label = label(:text => '', :layout => {:align => :left}, :frame => [0,0,110,25])
      end
    end
  end
  
  def combox_box_view
    @account_box = combo_box(
      :frame => [0,0,50,25], 
      :data => application.accounts, 
      :layout => {:expand => :width, :start => true, :align => :center}
    )
  end

end