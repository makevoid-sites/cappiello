Cappiello::Application.routes.draw do

  get "/stats", to: "pages#stats", as: :stats

  get "/pages/form_confirmation", to: "pages#form_confirmation", as: :form_confirmation
  get "/pages/offerta_formativa", to: "pages#offer", as: :offer
  get "/pages/training_offer", to: "pages#offer", as: :offer_en

  get "/pages/form", to: redirect("/pages/info")
  get "/pages/web_design_visual_design", to: redirect("/pages/corso_web_design")
  get "/pages/autocad_interior_design", to: redirect("/pages/corso_autocad_interior_design")
  get "/pages/v-ray", to: redirect("/pages/corso_v-ray")
  get "/pages/grafica_editoriale", to: redirect("/pages/corso_grafica_editoriale")
  get "/pages/pages/illustrazione_visual_design", to: redirect("/pages/corso_illustrazione_visual_design")
  get "/pages/photoshop_visual_design", to: redirect("/pages/corso_photoshop")
  get "/pages/rendering_interior_design", to: redirect("/pages/corso_rendering_interior_design")
  get "/pages/sketch_up_interior_design", to: redirect("/pages/corso_sketch_up_interior_design")
  get "/pages/3d_studio_max_interior_design", to: redirect("/pages/corso_3d_studio_max_interior_design")
  get "/pages/:id", to: "pages#show", as: :page
  resources :pages


  #get "/users/:name_url", to: "users#show", as: :user_path
  get "/users/new", to: "users#new", as: :new_user
  get "/users/newsletter", to: "users#newsletter", as: :user_newsletter
  get "/users/reset_password_form", to: "users#reset_password_form", as: :reset_password_form_user
  get "/users/reset_password_success", to: "users#reset_password_success", as: :reset_password_success
  post "/users/reset_password_send", to: "users#reset_password_send", as: :reset_password_send
  # todo: add user to every route?
  post "/users/reset_password", to: "users#reset_password", as: :reset_password
  put "/users/:token/change_password", to: "users#change_password", as: :change_password_user

  get "/users/reset_password/:token", to: "users#reset_password_edit", as: :reset_password_edit
  get "/users/:name_url", to: "users#show", as: :user
  resources :users do
    # just a reminder:

    # collection do
      # get "newsletter"
    # end
    # get 'newsletter', :on => :collection
  end

  get "/login", to: "sessions#new", as: :login_page
  post "/login", to: "sessions#create", as: :login
  get "/logout", to: "sessions#destroy", as: :logout


  get "/news/:id", to: "articles#show"
  get "/news", to: "articles#index"
  get "/events/:id", to: "articles#show", as: :event
  get "/news/:id", to: "pages#show", as: :article
  resources :news, controller: :articles
  resources :articles

  resources :photos
  resources :works

  get "/pdf_open/:name", to: "pages#pdf"
  get "/pdf_open/en/:name", to: "pages#pdf_en"

  root :to => "pages#index"
end
