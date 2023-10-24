require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET /show" do
    it "succeeds" do
      get profile_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "Put update" do
    it "updates the profile" do
      expect do
        put profile_path, params: {
          user: {
            bio: "new profile"
          }
        }
      end.to change { user.reload.bio }.from(nil).to("new profile")
      expect(response).to redirect_to(profile_path)
    end
  end
end
