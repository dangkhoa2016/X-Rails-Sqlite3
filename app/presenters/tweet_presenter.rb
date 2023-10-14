class TweetPresenter
  include ActionView::Helpers::DateHelper
  include Rails.application.routes.url_helpers

  def initialize(tweet:, current_user:)
    @tweet = tweet
    @current_user = user
  end

  attr_reader :tweet, :current_user

  delegate :user, :body, :likes_count, to: :tweet
  delegate :display_name, :username, :avatar, to: :user

  def created_at
    if (Time.zone.now - tweet.created_at) > 1.day
      tweet.created_at.strftime("%b %-d")
    else
      time_ago_in_words(tweet.created_at)
    end
  end

  def like_tweet_url
    if tweet_liked_by_current_user?
      tweet_like_path(tweet, current_user.likes.find_by(tweet: tweet))
    else
      tweet_likes_path(tweet)
    end
  end

  def turbo_data_method
    if tweet_liked_by_current_user?
      "delete"
    else
      "post"
    end
  end

  def like_heart_image
    if tweet_liked_by_current_user?
      '
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-6 h-6" width="18">
          <path d="M11.645 20.91l-.007-.003-.022-.012a15.247 15.247 0 01-.383-.218 25.18 25.18 0 01-4.244-3.17C4.688 15.36 2.25 12.174 2.25 8.25 2.25 5.322 4.714 3 7.688 3A5.5 5.5 0 0112 5.052 5.5 5.5 0 0116.313 3c2.973 0 5.437 2.322 5.437 5.25 0 3.925-2.438 7.111-4.739 9.256a25.175 25.175 0 01-4.244 3.17 15.247 15.247 0 01-.383.219l-.022.012-.007.004-.003.001a.752.752 0 01-.704 0l-.003-.001z" />
        </svg>
      '
    else
      '
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6" width="18">
          <path stroke-linecap="round" stroke-linejoin="round" d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z" />
        </svg>
      '
    end
  end

  private

  def tweet_liked_by_current_user
    @tweet_liked_by_current_user ||= tweet.liked_users.include?(current_user)
  end
  alias_method :tweet_liked_by_current_user?, :tweet_liked_by_current_user
end
