require 'rails_helper'

RSpec.describe Tweet, type: :model do
  it { should belong_to :user }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:liked_users).through(:likes) }
  it { should have_many(:bookmarks).dependent(:destroy) }
  it { should have_many(:bookmarked_users).through(:bookmarks).source(:user) }
  it { should have_many(:retweets).dependent(:destroy) }
  it { should have_many(:retweeted_users).through(:retweets).source(:user) }
  it { should have_many(:views).dependent(:destroy) }
  it { should have_many(:viewed_users).through(:views).source(:user) }
  it { should belong_to(:parent_tweet).with_foreign_key(:parent_tweet_id).class_name("Tweet").inverse_of(:reply_tweets).optional }
  it { should have_many(:reply_tweets).with_foreign_key(:parent_tweet_id).class_name("Tweet") }
  it { should have_and_belong_to_many(:hashtags) }
  it { should have_many(:mentions).dependent(:destroy) }
  it { should have_many(:mentioned_users).through(:mentions) }
  it { should validate_presence_of(:body) }
  it { should validate_length_of(:body).is_at_most(280) }

  describe "saving hashtags" do
    let(:user) { create(:user)
    }
    context "when there are no hastags in the body" do
      it "does not create any hastag" do
        expect do
          Tweet.create(user: user, body: "today is the best day")
        end.not_to change { Hashtag.count }
      end
    end

    context "when there are hastags in the body" do
      it "create any hastag" do
        expect do
          Tweet.create(user: user, body: "#today is the best #day")
        end.to change { Hashtag.count }.by(2)
      end

      it "creates hashtags assigned to the tweet" do
        tweet = Tweet.create(user: user, body: "#today is the best #day")
        expect(tweet.hashtags.size).to eq(2)
      end
    end

    context "when there are duplicate hastags in the body" do
      it "does not create an extra hashtag if already in the database table" do
        Hashtag.create(tag: "day")
        expect do
          Tweet.create(user: user, body: "#today is the best #day")
        end.to change { Hashtag.count }.by(1)
      end
    end
  end

  describe "saving mentions" do
    let(:user) { create(:user) }

    context "when there are not mentions in the body" do
      it "does not create any new mentions" do
        expect do
          Tweet.create(user: user, body: "this is a test")
        end.not_to change { Mention.count }
      end
    end

    context "when there are mentions in the body" do
      it "creates new mentions" do
        user = User.create(email: "test@mail.com", username: "test", password: "password")
        expect do
          Tweet.create(user: user, body: "this is a test for @test")
        end.to change { Mention.count }.by(1)
      end
      it "creates a new notification" do
        user = User.create(email: "test@mail.com", username: "test", password: "password")
        expect do
          Tweet.create(user: user, body: "this is a test for @test")
        end.to change { Notification.count }.by(1)
      end
    end
  end
end
