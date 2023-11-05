require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  describe "GET /index" do
    let(:user) { create(:user) }

    before { sign_in user }

    describe "GET index" do
      it "succedds" do
        get notifications_path
        expect(response).to have_http_status(:success)
      end
    end
  end
end
