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
     application.accounts << @new_account_name.stringValue unless application.accounts.include?(@new_account_name.stringValue)
     NSUserDefaults.standardUserDefaults.setObject(application.accounts, forKey:"accounts")
     NSUserDefaults.standardUserDefaults.synchronize
     application.load_accounts
     @account_box.data = application.accounts
    }
  end
  
end