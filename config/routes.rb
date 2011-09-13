Chorechart::Application.routes.draw do

  resources :groups, :shallow => true do 
    resources :memberships, :only => [:index, :create, :update, :destroy]
    resources :chores, :except => :show
  end

  devise_for :users, 
    :path => '', 
    :path_names => { 
      :sign_in => 'login', 
      :sign_out => 'logout', 
      :registration => 'account', 
      :sign_up => 'create' 
    } do
    get 'dashboard', :to => 'users#dashboard', :as => :user_root
  end

  root :to => "pages#index"

end
