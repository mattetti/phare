module AccountSetupController
  
  def save_api_key
    Proc.new { 
      NSUserDefaults.standardUserDefaults.setObject(@api_token.stringValue, forKey:"apiToken")
      NSUserDefaults.standardUserDefaults.synchronize
      application.load_api_token
      @api_token.stringValue = application.api_token || ''
      @save_label.text = 'API Token saved'
    }
  end
  
  def add_project
    Proc.new{
     Logger.info('this is where we will store the saved projects')
     application.accounts << @new_account_name.stringValue
     @account_box.data = application.accounts
    }
  end
  
end