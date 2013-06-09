require 'spec_helper'

describe "Playlists" do
  before do
    @playlist = FactoryGirl.create(:playlist)
    @valid_url = 'https://www.youtube.com/watch?v=JcniyQYFU6M'
    @malformed_youtube_url = 'https://www.youtube.com/watch?v=JcniyQYF'
  end
  subject { page }

  describe "Index" do
    before { visit playlists_path } 
    it { should have_content @playlist.name }
    it { should have_link @playlist.name }

    describe "Playlist link is clickable" do
    end
  end
  
  describe "Show" do
    before { visit playlist_path(@playlist)  } 
    it { should have_content @playlist.videos.first.name }
    it { should have_button 'Add' }

    describe "Add a video" do
      before { fill_in "video_url_raw", with: @valid_url } 
      it "should add a video" do
        expect { click_button 'Add' }.to change(Video, :count).by 1
      end
    end

    describe "Add an invalid video" do
      before { fill_in "video_url_raw", with: @malformed_youtube_url } 
      it "should not add a video" do
        expect { click_button 'Add' }.not_to change(Video, :count)
      end
    end

    describe "Add a blank video" do
      it "should not add a video" do
        expect { click_button 'Add' }.not_to change(Video, :count)
      end
    end

    describe "Add a duplicate video" do
      before do
        fill_in "video_url_raw", with: @valid_url 
        click_button 'Add'
        #research why hitting add here (js format) redirects
        visit playlist_path(@playlist) 
        fill_in "video_url_raw", with: @valid_url 
      end
      it "should not add a video" do
        expect { click_button 'Add' }.not_to change(Video, :count)
      end
    end

    describe "Click a different video in playlist" do
    end

    describe "Pagination with > 10 videos" do
    end
  end

end
