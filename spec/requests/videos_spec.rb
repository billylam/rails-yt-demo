require 'spec_helper'

describe "Videos" do
  before { @video = FactoryGirl.create(:video) }
  subject { page }

  describe "Index" do
    before { visit videos_path }
    it { should have_link @video.name }
  end
end
