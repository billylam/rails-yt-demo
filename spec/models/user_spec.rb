require 'spec_helper'

describe User do
  before { @user = FactoryGirl.build(:user) } 
  subject { @user }

  it { should respond_to :username }
  it { should respond_to :email }

  describe "validation" do
    describe "that username is unique" do
      before { FactoryGirl.create(:user, username: @user.username) }
      it { should_not be_valid }
    end

    describe "when username is blank" do
      before { @user.username = "" }
      it { should_not be_valid }
    end

    describe "that username is between 6 and 16 characters inclusive" do
    end

    describe "that username is alphanumeric" do
    end
    
    describe "that email is optional" do
      before { @user.email = "" }
      it { should be_valid }
    end
  end
end
