require 'spec_helper'

describe Playlist do
  before do
    @user = FactoryGirl.create(:user)
    @playlist = @user.playlists.build(name:"Playlist")
  end

  subject { @playlist }

  it { should respond_to :name }
  it { should respond_to :user_id }
  it { should respond_to :user }
  it { should respond_to :add }
  its(:user) { should == @user }

  describe "when user_id is not present" do
    before { @playlist.user_id = nil }
    it { should_not be_valid }
  end

  describe "add a video" do
    before do
      video = FactoryGirl.create(:video)
      @playlist.add(video)
    end

    its(:videos) { should include video}
  end
end
