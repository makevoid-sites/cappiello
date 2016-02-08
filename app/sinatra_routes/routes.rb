require 'sinatra' #ngularrails!

require 'config/sinatra_env'
include SinatrAntani

get "/pages/:id" do 
  page = Page.new
  render_from_views :"pages/show"
end

get "/courses"


get "/admin"

registration key based

class KeyBasedRegistration

  generate_account
  
  SMS verification
  
  load brainwallet

end

module SinatrAntani
  def render_from_views(view)
    render view
  end
end

