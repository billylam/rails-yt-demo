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

    describe "with valid information and no seed playlists" do
      before do
        fill_in "Username", with: @user.username
        fill_in "Password", with: @user.password
        click_button "Sign in"
      end

      it { should_not have_selector('div.alert.alert-error') }
      it { should have_selector('a', text: "Sign Out") }
      it { should have_selector('a', text: "My Playlists") }
      it { should_not have_selector('a', text: "Register") }
      it { should_not have_selector('a', text: "Sign In") }

      it "should redirect to playlists index" do
        current_path.should == playlists_path
      end
    end

    describe "with valid information and playlists" do
      before do
        FactoryGirl.create(:playlist)
        fill_in "Username", with: @user.username
        fill_in "Password", with: @user.password
        click_button "Sign in"
      end

      it "should redirect to root" do
        current_path.should == root_path
      end
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
