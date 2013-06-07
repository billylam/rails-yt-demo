require 'spec_helper'

describe Video do
  before { @video = FactoryGirl.build(:video) } 
  subject { @video }

  it { should respond_to :youtube_id }
  it { should respond_to :rating }
  it { should respond_to :name }
  it { should respond_to :pl_additions }

  describe "validation" do
    describe "when video is already in db" do
      before { FactoryGirl.create(:video, youtube_id: @video.youtube_id) }
      it { should_not be_valid }
    end
  end
end
