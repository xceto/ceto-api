Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


post 'dashboard' => 'dashboard#index', as: :buscador

root to: "dashboard#index"

resources :dashboard

post 'dashboard/new', to: 'dashboard#new'

	namespace :api do
		resources :v1, format: :json
	end

end