Chorechart::Application.routes.draw do

  resources :groups, :shallow => true do 
    resources :memberships
  end

  resources :chores

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
