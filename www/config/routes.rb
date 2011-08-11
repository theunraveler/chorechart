Chorechart::Application.routes.draw do

  resources :groups, :shallow => true do 
    resources :memberships, :only => [:index, :create, :update, :destroy]
    resources :chores
  end


  devise_for :users, 
    :path => '', 
    :path_names => { 
      :sign_in => 'login', 
      :sign_out => 'logout', 
      :registration => 'account', 
      :sign_up => 'create' 
    } do
    get 'account', :to => 'users#show', :as => :user_root
  end

  root :to => "pages#index"

end
