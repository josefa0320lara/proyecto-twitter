include ActionView::Helpers::UrlHelper

class Tweet < ApplicationRecord
  before_save :add_hashtags

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liking_users, :through => :likes, :source => :user

  validates :content, :presence => true

  paginates_per 50

  scope :tweets_for_me, -> (user) { where(user_id: user.arr_friends_id_and_me) }

  def add_hashtags
    new_content = ""
    self.content.split(" ").each do |word|
      if word.start_with?("#")
        word_clean = word.gsub("#", "")
        new_content += '<a href="/?search='+word_clean+'">'+word+'</a>'
        #new_content += link_to(word, Rails.application.routes.url_helpers.root_path+"?search="+word_clean)+ " "
      else
        new_content += word + " "
      end
    end
    self.content = new_content
  end


  def is_liked?(user)
    self.liking_users.include?(user)

  end

  def like(user)
    Like.create(user: user, tweet: self)
  end

  def remove_like(user)
    Like.where(user: user, tweet: self).destroy_all

  end

  def count_rt
    Tweet.where(rt_ref: self.id).count
  end

  def is_retweet?   
    self.rt_ref.present?
  end

  def tweet_ref
    Tweet.find(self.rt_ref )
  end

  ##def self.most_liked 
  #  array = Like.all.pluck(:tweet_id)
  #  hash = array.inject(Hash.new(0)) { |h, x| h[x] += 1; h} 
   # hash.sort_by { |k, v| v }.last(5).to_h
  #end

end
