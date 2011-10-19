Chorechart::Application.routes.draw do

  resources :groups, :shallow => true do 
    resources :memberships, :only => [:index, :create, :update, :destroy]
    resources :chores, :except => :show
    resources :invitations, :only => [:new, :create, :destroy]
  end

  devise_for :users, 
    :path => '', 
    :path_names => { 
      :sign_in => 'login', 
      :sign_out => 'logout', 
      :registration => 'account', 
      :sign_up => 'create' 
    },
    :controllers => {
      :sessions => 'sessions',
      :registrations => 'registrations'
    } do
    get 'dashboard', :to => 'users#dashboard', :as => :user_root
  end

  match '/auth/:provider/callback' => 'authentications#create'
  scope '/account' do 
    resources :authentications
  end

  root :to => "pages#index"

end
