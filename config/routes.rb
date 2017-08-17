Rails.application.routes.draw do
  root to: 'home#index'

  get '/auth/:provider/callback' => 'sessions#create'
  get "/signout" => "sessions#destroy", :as => :signout
  get '/auth/failure' => 'sessions#failure'

  resources :users
  resources :home
  resources :sessions

  namespace :stock do
    root to: 'home#index'

    get "/humen/search_results" => "humen#search_results"
    get "/human_samples/search_results" => "human_samples#search_results"
    get "/human_samples/batch_search" => "human_samples#batch_search"
    get "/human_samples/batch_search_results" => "human_samples#batch_search_results"
    get "/datasets/search_results" => "datasets#search_results"
    get "/visits/search_results" => "visits#search_results"

    resources :home
    resources :humen
    resources :cohorts
    resources :human_samples
    resources :sample_types
    resources :materials
    resources :carts
    resources :visits
    resources :favorites
  end

  namespace :fep do
    root to: 'home#index'

    get "/projects/search_results" => "projects#search_results"
    get "/datasets/search_results" => "datasets#search_results"

    resources :home
    resources :humen
    resources :projects
    resources :datasets
  end

  namespace :clinic do
    root to: 'home#index'
    
    get "/humen/search_results" => "humen#search_results"

    resources :home
    resources :events
    resources :humen
    resources :demographies
    resources :irbs
    resources :visits
  end

  namespace :admin do
    root to: 'home#index'

    get "/humen/batch_new" => "humen#batch_new"
    get "/humen/batch_edit" => "humen#batch_edit"
    post "/humen/batch_create" => "humen#batch_create"
    post "/humen/batch_update" => "humen#batch_update"
    post "/humen/confirm_create" => "humen#confirm_create"
    post "/humen/confirm_update" => "humen#confirm_update"
    get "/humen/send_template" => 'humen#send_template'
    get "/humen/search_results" => "humen#search_results"
    
    get "/visits/batch_new" => "visits#batch_new"
    get "/visits/batch_edit" => "visits#batch_edit"
    post "/visits/batch_create" => "visits#batch_create"
    post "/visits/batch_update" => "visits#batch_update"
    post "/visits/confirm_create" => "visits#confirm_create"
    post "/visits/confirm_update" => "visits#confirm_update"
    get "/visits/send_template" => 'visits#send_template'
    get "/visits/search_results" => "visits#search_results"
    
    get "/human_samples/batch_new" => "human_samples#batch_new"
    get "/human_samples/batch_edit" => "human_samples#batch_edit"
    post "/human_samples/batch_create" => "human_samples#batch_create"
    post "/human_samples/batch_update" => "human_samples#batch_update"
    post "/human_samples/confirm_create" => "human_samples#confirm_create"
    post "/human_samples/confirm_update" => "human_samples#confirm_update"
    get "/human_samples/send_template" => 'human_samples#send_template'
    get "/human_samples/search_results" => "human_samples#search_results"
    
    get "/transfers/batch_new" => "transfers#batch_new"
    post "/transfers/batch_create" => "transfers#batch_create"
    post "/transfers/confirm_create" => "transfers#confirm_create"
    get "/transfers/send_template" => 'transfers#send_template'
    get "/transfers/search_results" => "transfers#search_results"
    
    get "/datasets/search_results" => "datasets#search_results"

    resources :home
    resources :users
    resources :groups
    resources :humen
    resources :statuses
    resources :populations
    resources :visits
    resources :visit_types
    resources :genders
    resources :races
    resources :cohorts
    resources :human_samples
    resources :sample_types
    resources :main_locations
    resources :datasets
    resources :materials
    resources :transfers
    resources :projects

  end
end
