require 'rails_helper'

RSpec.describe "Reply Tweets", type: :request do
  let(:user) { create(:user) }
  let(:parent_tweet) { create(:tweet) }

  before { sign_in user }

  describe "POST create" do
    before { parent_tweet }

    it "create a new tweet" do
      expect do
        post tweet_reply_tweets_path(parent_tweet), params: {
          tweet: {
            body: "New tweet body"
          }
        }
      end.to change { Tweet.count }.by(1)
      expect(response).to redirect_to(dashboard_path)
    end

    it "create a new TweetActivity" do
      expect do
        post tweet_reply_tweets_path(parent_tweet), params: {
          tweet: {
            body: "New tweet body"
          }
        }
      end.to change { Tweet.count }.by(1)
    end
  end
end
