class HomeController < ApplicationController
  def index
    if signed_in? 
      @tweets = Tweet.tweets_for_me(current_user).where("content LIKE ?", "%#{params[:search]}%").order(created_at: :desc).page params[:page]
    else
      @tweets = Tweet.where("content LIKE ?", "%#{params[:search]}%").order(created_at: :desc).page params[:page]
    end

    @tweet = Tweet.new
    @users = User.all
  end

  def all_tweets
    @tweets = Tweet.order(created_at: :desc).page params[:page]
    @tweet = Tweet.new

    #most_liked_tweets = Tweet.most_liked.keys.reverse
  
    #@tweets_liked = most_liked_tweets.map { |tweet_id| Tweet.find(tweet_id) }

    render "index"
  end

  def my_profile
    @users = User.all
    @friends = current_user.arr_friends_id
  end

end
