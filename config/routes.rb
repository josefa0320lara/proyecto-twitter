Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  resources :tweets do
    post 'likes', to: 'tweets#likes'
    post 'retweet', to: 'tweets#retweet'
  end

  devise_for :users
  
  get 'home/index'
  get 'home/my_profile'
  get 'home/all_tweets', to: 'home#all_tweets', as: 'all_tweets'
  post 'follow/:friend_id', to: 'users#follow', as: 'users_follow'

  #get 'api/news'
  scope '/api' do
    get'/news', to: 'api#news', as: 'api_news'
  end

  root to: 'home#index'
end
