require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  describe "GET /dashboard" do
    context "when not sign in" do
      it "respond with redirect" do
        get dashboard_path
        expect(response).to have_http_status(:redirect)
      end
    end

    context "when logged in" do
      it "responds with success" do
        user = create(:user, :unique_email)
        sign_in user
        get dashboard_path
        expect(response).to have_http_status(:success)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  describe "GET /dashboard" do
    context "when not signed in" do
      it "responds with redirect" do
        get dashboard_path
        expect(response).to have_http_status(:redirect)
      end
    end

    context "when logged in" do
      it "responds with success" do
        user = create(:user, :unique_email)
        sign_in user  # Sign in the user

        # Make the request to the dashboard
        get dashboard_path

        expect(response).to have_http_status(:success)
      end
    end
  end
end
