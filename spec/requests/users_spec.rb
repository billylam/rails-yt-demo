require 'spec_helper'

describe "Users" do
  subject { page }

  describe "Signup" do
    before { visit signup_path }
    let(:submit) { "Sign Up" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Username", with: "Foobar"
        fill_in "Password", with: "foobar1"
        fill_in "Confirm Password", with: "foobar1"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end
