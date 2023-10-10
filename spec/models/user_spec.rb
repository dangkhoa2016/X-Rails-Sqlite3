require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:tweets).dependent(:destroy) }
  it { should validate_uniqueness_of(:username).case_insensitive.allow_blank }

  describe "set display name" do
    context "when display name is set" do
      it "does not change the display name" do
        user = build(:user, username: "test", display_name: "Test Test")
        user.save
        expect(user.reload.display_name).to eq("Test Test")
      end
    end

    context "when display name is not set" do
      it "humanizes the previously set username" do
        user = build(:user, username: "test", display_name: nil)
        user.save
        expect(user.reload.display_name).to eq("Test")
      end
    end
  end
end
