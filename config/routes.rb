InvestigateNet::Application.routes.draw do
 
  root :to => "http://localhost#index"  

  resources :messages, :collaborators, :privacies, :sessions

  get "answers/new"

  get "admin/expert/new"
  post "admin/expert/new"
  
  get "researchers/browse"

  get "researchers/search"

  get "researchers/search_results"

  get "researchers/collaborators"

  # get "researchers/doSearch"

  get "admin/researchers/search"

  get "admin/researchers/search_results"

  get "researchers/questions" 
  get "questions" => "questions#new", :as => "new_question"
  # get "questions" => "questions#edit", :as => "edit_question"
  
  post "user_session/new"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "researchers#new", :as => "sign_up"
  
  devise_for :admins

  resources :questions, :only => [:new, :create, :show, :edit, :update] #do
    #member do
      #get :edit
      #put :edit
    #end
  #end
  resources :answers, :only => [:show, :edit, :update] do
    get :no_answer, :on => :member
  end

  namespace :admin do
      resources :questions, :only => [:index, :show, :edit]
      resources :answers, :only => [:create]
      resources :researchers, :only => [:index] do
      get :activate, :on => :member
      get :deactivate, :on => :member
      get :activate_admin, :on => :member
      get :deactivate_admin, :on => :member
    end
    resources :expert, :only => [:index] do
      get :activate, :on => :member
      get :deactivate, :on => :member
    end
  end

  resources :researchers do
    member do
      get :collaborate
      get :uncollaborate
    end
    collection do
      get 'doSearch'
    end
  end
  
  resources :messages do
    member do
      get :reply
    end
  end
  

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  match '/admin/expert' => 'admin/expert#index'
end
