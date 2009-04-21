require 'hotcocoa'
framework 'webkit'
include HotCocoa
Dir.glob(File.join(File.dirname(__FILE__), 'vendor', '*.rb')).each do |file|
  require file
end

class Application < HotCocoaApplication
  include MacRuby::DownloadHelper
  
  attr_reader   :api_token
  attr_accessor :accounts
  
  def accounts
    @accounts ||= []
  end
  
  def start
    load_api_token
    load_accounts
    
    application :name => "phare" do |app|
      app.delegate = self
      @main_window = window :frame => [100, 100, 1024, 800], :title => "lighthouseapp.com" do |win|
        win << segment_control
        win.will_close { exit }
      end
      if (api_token && (api_token.length == 40))
        display('ProjectSelectionView')
      else
        # Switch to the lighthouse account if the user didn't provide a token or
        # if it's not valid
        display("AccountSetupView")
      end
    end
  end
  
  def load_api_token
    @api_token = NSUserDefaults.standardUserDefaults.stringForKey("apiToken")
  end

  def load_accounts
    @accounts = NSUserDefaults.standardUserDefaults.arrayForKey("accounts")
  end
    
end

APP = Application.new