Cappiello::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  get "/stats", to: "pages#stats", as: :stats
  get "/pages/:id", to: "pages#show", as: :page
  resources :pages

  
  #get "/users/:name_url", to: "users#show", as: :user_path
  get "/users/new", to: "users#new", as: :new_user
  get "/users/:name_url", to: "users#show", as: :user
  resources :users
  
  get "/login", to: "sessions#new", as: :login_page
  post "/login", to: "sessions#create", as: :login
  get "/logout", to: "sessions#destroy", as: :logout


  get "/news/:id", to: "articles#show", as: :news
  get "/events/:id", to: "articles#show", as: :event
  get "/news/:year/:month/:day/:id", to: "articles#show", as: :news_date
  get "/events/:year/:month/:day/:id", to: "articles#show", as: :event_date
  resources :articles
  
  resources :photos
  resources :works
  
  get "/pdf_open/:name", to: "pages#pdf"
  get "/pdf_open/en/:name", to: "pages#pdf_en"
  
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "pages#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  
  old_routes = ["/indexMaster.asp",
   "/eventiDett.asp",
   "/stages.asp",
   "/corsiIni.asp",
   "/newsDett.asp",
   "/contatti.asp",
   "/dateOrari.asp",
   "/news.asp",
   "/index.asp",
   "/lavoro.asp",
   "/corsiSpecial.asp",
   "/form.asp",
   "/lavoroOffroDett.asp",
   "/eventi.asp",
   "/borse.asp",
   "/lavoroCercoDett.asp",
   "/html/eventi.html",
   "/html/stagesgratis.html",
   "/html/news_html.asp",
   "/html/cors_nf.html",
   "/html/contatto.html",
   "/html/illustrazione.html",
   "/html/borse.html",
   "/html/chis_nf.html",
   "/html/corsibrevi_nf.html",
   "/index.html",
   "/html/lavoro.html",
   "html/ienf.html"]
   
  old_routes.each do |route|
    match route => redirect("http://accademia-cappiello.it/")
  end
end
