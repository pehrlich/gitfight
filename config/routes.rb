Gitfite::Application.routes.draw do

  get 'fights/recent'
  resources :fights

  devise_for :users
  root :to => 'fights#index'

  # hack until rails 3.1.  http://techoctave.com/c7/posts/36-rails-3-0-rescue-from-routing-error-solution
  # breaks engines if present.
  match '*a', :to => 'application#error_404'

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
#== Route Map
# Generated on 26 Apr 2011 15:04
#
#                   root        /(.:format)                     {:controller=>"fights", :action=>"index"}
#            contestants GET    /contestants(.:format)          {:controller=>"contestants", :action=>"index"}
#                        POST   /contestants(.:format)          {:controller=>"contestants", :action=>"create"}
#         new_contestant GET    /contestants/new(.:format)      {:controller=>"contestants", :action=>"new"}
#        edit_contestant GET    /contestants/:id/edit(.:format) {:controller=>"contestants", :action=>"edit"}
#             contestant GET    /contestants/:id(.:format)      {:controller=>"contestants", :action=>"show"}
#                        PUT    /contestants/:id(.:format)      {:controller=>"contestants", :action=>"update"}
#                        DELETE /contestants/:id(.:format)      {:controller=>"contestants", :action=>"destroy"}
#                 fights GET    /fights(.:format)               {:controller=>"fights", :action=>"index"}
#                        POST   /fights(.:format)               {:controller=>"fights", :action=>"create"}
#              new_fight GET    /fights/new(.:format)           {:controller=>"fights", :action=>"new"}
#             edit_fight GET    /fights/:id/edit(.:format)      {:controller=>"fights", :action=>"edit"}
#                  fight GET    /fights/:id(.:format)           {:controller=>"fights", :action=>"show"}
#                        PUT    /fights/:id(.:format)           {:controller=>"fights", :action=>"update"}
#                        DELETE /fights/:id(.:format)           {:controller=>"fights", :action=>"destroy"}
#       new_user_session GET    /users/sign_in(.:format)        {:controller=>"devise/sessions", :action=>"new"}
#           user_session POST   /users/sign_in(.:format)        {:controller=>"devise/sessions", :action=>"create"}
#   destroy_user_session GET    /users/sign_out(.:format)       {:controller=>"devise/sessions", :action=>"destroy"}
#          user_password POST   /users/password(.:format)       {:controller=>"devise/passwords", :action=>"create"}
#      new_user_password GET    /users/password/new(.:format)   {:controller=>"devise/passwords", :action=>"new"}
#     edit_user_password GET    /users/password/edit(.:format)  {:controller=>"devise/passwords", :action=>"edit"}
#                        PUT    /users/password(.:format)       {:controller=>"devise/passwords", :action=>"update"}
#      user_registration POST   /users(.:format)                {:controller=>"devise/registrations", :action=>"create"}
#  new_user_registration GET    /users/sign_up(.:format)        {:controller=>"devise/registrations", :action=>"new"}
# edit_user_registration GET    /users/edit(.:format)           {:controller=>"devise/registrations", :action=>"edit"}
#                        PUT    /users(.:format)                {:controller=>"devise/registrations", :action=>"update"}
#                        DELETE /users(.:format)                {:controller=>"devise/registrations", :action=>"destroy"}
#             styleguide GET    /styleguides(.:format)          {:controller=>"flutie/styleguides", :action=>"show"}
