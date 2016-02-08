require_relative 'env'

class Project
  property :id, Serial

  property :name, String
  property :images, String
  property :description, String # markdown, with links et al
end

class Profile
  get "/" do
    haml :profile
  end

  get "/edit" do
    haml :profile_edit
  end

  put "/" do
    user_id = session[:user_id]
    @user = User.get user_id
    @user.update
    redirect "/"
  end
end
