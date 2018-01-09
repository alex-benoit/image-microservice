Rails.application.routes.draw do
  post 'photos', to: 'photos#create'
  get 'photos/:id', to: 'photos#show', as: :photo

  get 'photos/:id/transform', to: 'photo_transformations#create'
  get 'transformations/:id', to: 'photo_transformations#show', as: :transformation
end
