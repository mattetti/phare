module LighthouseAPi

  def get_projects(account, token)
    "http://#{account}.lighthouseapp.com/projects.json?_token=#{token}"
  end
    
end