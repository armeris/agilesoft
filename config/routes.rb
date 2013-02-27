Agilesoft2::Application.routes.draw do
  devise_for :users

  resources :comments, :only => [:create, :destroy]
  
  get "/posts/:post_id" => "blogs#show", :as => "posts"
  get "/blogs/:post_id" => "blogs#show"
  delete "/posts/delete/:post_id" => "blogs#delete_post", :as => "post_delete"
  delete "/comments/delete/:comment_id" => "blogs#delete_comment", :as => "comment_delete"
  get "/about" => "blogs#about"
  post "/posts/:post_id/save_comment" => "blogs#save_comment", :as => "save_comment"
  get "/create_post" => "blogs#create_post"
  get "/posts_list" => "blogs#post_list"
  get "/edit_post/:post_id" => "blogs#edit_post", :as => "edit_post"
  post "/save_post" => "blogs#save_post"
  post "/visible/:post_id" => "blogs#visible_post", :as => "visible"
  get '/rss' => 'blogs#rss'

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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'blogs#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
