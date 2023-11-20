# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    following_users = current_user.following_users

    @tweet = Tweet.includes(:liked_users, :bookmarked_users, :retweeted_users, :user).where(user: following_users).order(created_at: :desc).map do |tweet|
      TweetPresenter.new(tweet: tweet, current_user: current_user)
    end

    @tweet_activities = current_user.tweet_activities.order(created_at: :desc).map do |tweet_activity|
      TweetPresenter.new(tweet: tweet_activity.tweet, current_user: current_user)
    end
  end
end
