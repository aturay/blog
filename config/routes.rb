Rails.application.routes.draw do
  resources :posts

  post 'set_post'   , to: 'posts#set_post'
  post 'set_rating' , to: 'posts#set_rating'

  get 'get_top_posts/:n', to: 'posts#get_top_posts'
  get 'get_top_posts'   , to: 'posts#get_top_posts'
  get 'get_lists_ip'    , to: 'posts#get_lists_ip'
end
