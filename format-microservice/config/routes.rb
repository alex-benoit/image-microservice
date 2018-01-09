Rails.application.routes.draw do
  post 'modify_format', to: 'formats#modify_format'
end
