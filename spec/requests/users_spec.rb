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

  describe "Signin" do
    before do
      @user = FactoryGirl.create(:user)
      visit signin_path
    end

    describe "with valid information" do
      before do
        fill_in "Username", with: @user.username
        fill_in "Password", with: @user.password
        click_button "Sign in"
      end

      it { should_not have_selector('div.alert.alert-error') }
    end

    describe "with no information" do
      before do
        click_button "Sign in"
      end

      it { should have_selector('div.alert.alert-error') }
    end

    describe "with invalid information" do
      before do
        fill_in "Username", with: "invalid"
        fill_in "Password", with: "x"
        click_button "Sign in"
      end

      it { should have_selector('div.alert.alert-error') }
    end
    
    describe "without persistent flash error message" do
    end
  end
end
