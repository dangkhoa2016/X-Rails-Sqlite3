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

    describe "Delete destroy" do
      it "deletes a record" do
        notification = create(:notification)
        expect do
          delete notification_path(notification), headers: { 'Accept': 'text/vnd.turbo-stream.html' }
        end.to change { Notification.count }.by(-1)
      end
    end
  end
end
