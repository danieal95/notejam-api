Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get  '/pads', to: "pads#index"
  post '/pads/create', to: "pads#create"
  put  '/pads/:id', to: "pads#update"
  get  '/pads/:id', to: "pads#show"
  delete '/pads/:id', to: "pads#delete"
end
