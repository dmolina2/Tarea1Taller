Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'films#index'
  resources :films
  resources :planets
  resources :characters
  resources :starships
  post "/films/new" => "films#new", :as => :new_forum

end
