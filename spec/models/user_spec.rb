require 'spec_helper'

describe User do
  before { @user = FactoryGirl.build(:user) } 
  subject { @user }

  it { should respond_to :username }
  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :password_digest }


  describe "validation" do
    describe "that username is unique" do
      before { FactoryGirl.create(:user, username: @user.username) }
      it { should_not be_valid }
    end

    describe "when capitalized version of username exists" do
      before { FactoryGirl.create(:user, username: @user.username.upcase) }
      it { should_not be_valid }
    end

    describe "when username is blank" do
      before { @user.username = "" }
      it { should_not be_valid }
    end

    describe "that username is between 6 and 32 characters inclusive" do
      before { @user.username = "a" * 33}
      it { should_not be_valid }
    end

    describe "that username is alphanumeric" do
    end
    
    describe "that email is optional" do
      before { @user.email = "" }
      it { should be_valid }
    end

    describe "when password is blank" do 
      before { @user.password = @user.password_confirmation = "" }
        it { should_not be_valid }
    end

    describe "when passwords dont match" do
      before do
        @user.password = "foobar"
        @user.password_confirmation = "foobar2"
      end
      it { should_not be_valid }
    end

    describe "when password is too short" do
      before { @user.password = @user.password_confirmation = "a" }
      it { should_not be_valid }
    end
  end

  describe "authentication" do
    before do 
      @user.save
      @found_user = User.find_by_username(@user.username)
    end

    describe "with valid password" do
      it { should == @found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      before { @bad_pass_user = @found_user.authenticate("wrong password") }
      it { should_not == @bad_pass_user }
      specify { @bad_pass_user.should be_false }
    end

  end
end
