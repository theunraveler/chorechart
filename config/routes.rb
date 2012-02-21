Chorechart::Application.routes.draw do

  resources :groups, :shallow => true do
    resources :memberships, :only => [:index, :create, :destroy]
    resources :chores, :except => :show
    resources :invitations, :only => [:new, :create, :destroy]
  end

  devise_for :users,
    :path => '',
    :path_names => {
      :sign_in => 'login',
      :sign_out => 'logout',
      :registration => 'account',
      :sign_up => 'register'
    },
    :controllers => {
      :registrations => 'registrations'
    }
  devise_scope :users do
    get 'dashboard', :to => 'users#dashboard', :as => :user_root
  end

  match '/auth/:provider/callback' => 'authentications#create'
  scope '/account' do
    resources :authentications, :only => [:index, :create, :destroy]
  end

  root :to => 'pages#homepage'

end
