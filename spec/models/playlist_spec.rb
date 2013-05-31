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
  its(:user) { should == @user }

  describe "when user_id is not present" do
    before { @playlist.user_id = nil }
    it { should_not be_valid }
  end
end
