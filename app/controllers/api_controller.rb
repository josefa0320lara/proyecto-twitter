class ApiController < ApplicationController
  def news
    #render json: Tweet.last(5)
    tweets = Tweet.last(5)
    hash = tweets.map do |tweet|
      { 
        id: tweet.id, 
        content: tweet.content, 
        user_id: tweet.user_id, 
        like_count: tweet.likes.count, 
        retweets_count: tweet.count_rt, 
        retweeted_from: (tweet.rt_ref.nil? ? '-': tweet.rt_ref)
       }
      end
      render json: hash
  end
end
