Rails.application.routes.draw do
  post 'photos', to: 'photos#create'
  get 'photos/:id', to: 'photos#show'
end
