Bookpacker::Application.routes.draw do
  root 'books#index'
 resources :books

end
