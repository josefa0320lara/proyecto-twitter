class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liking_users, :through => :likes, :source => :user

  validates :content, :presence => true

  paginates_per 5

  scope :tweets_for_me, -> (user) { where(user_id: user.arr_friends_id_and_me) }
 

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

end
