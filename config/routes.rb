Rails.application.routes.draw do
  
  get 'debug/index'

  get 'home/index'
  get 'home' => 'home#index'
  
  root 'home#index'

end
