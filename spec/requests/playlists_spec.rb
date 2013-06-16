require 'spec_helper'
require "cancan/matchers"

describe "Playlists" do
  before do
    @playlist = FactoryGirl.create(:playlist)
    @valid_url = 'https://www.youtube.com/watch?v=JcniyQYFU6M'
    @malformed_youtube_url = 'https://www.youtube.com/watch?v=JcniyQYF'
  end
  subject { page }

  describe "Create" do
    before do
      name = "Playlist name"
      visit new_playlist_path
      fill_in "playlist_name", with: name
    end

    describe "New playlist" do
      it "should increment number of playlists" do
        expect { click_button 'Create playlist' }.to change(Playlist, :count).by 1
      end

      describe "should not have null name or description text" do
        it { should_not have_text('null') }
      end

      describe "add" do
        before { click_button 'Create playlist' }
        it "should redirect to playlist page" do
        end

        describe "should allow video addition" do
          it { should have_selector('input', 'Add') }
          it { should have_selector('input', 'video_url_raw') }
        end
      end
    end
  end

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

      describe "should have an alert" do
        #it { should have_selector('div.alert', 'was added to playlist.') }
      end
    end

    describe "Add an invalid video" do
      before { fill_in "video_url_raw", with: @malformed_youtube_url } 
      it "should not add a video" do
        expect { click_button 'Add' }.not_to change(Video, :count)
      end

      describe "should show an alert" do
        #before { click_button 'Add' }
        #it { should have_selector('div .alert', text: "Invalid video URL.") }
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
  end

  describe "Privacy" do
    before do
      user1 = FactoryGirl.create(:user)
      visit signin_path
      fill_in :username, with: user1.username
      fill_in :password, with: user1.password
      click_button "Sign in"
    end

    describe "Creator" do
      before { visit new_playlist_path }

      describe "Should be able to create Private playlists" do
        it { should have_unchecked_field("playlist_private") }
      end

      describe "Should be able to see own playlist" do
        before do 
          fill_in "Playlist name", with: "name"
          check('playlist_private')
          click_button "Create playlist"
        end

        it "and be redirected to playlist" do
          current_path.should == playlist_path(Playlist.last.id) 
        end
      end
    end


    describe "Anonymous" do
      before do
        visit new_playlist_path
        fill_in "Playlist name", with: "name"
        check('playlist_private')
        click_button "Create playlist"
        click_link "Sign Out"
        anon = User.first
        @ability = Ability.new(anon)
      end

      it {  @ability.should_not be_able_to(:view, Playlist.last) }

      describe "Private playlist should not be accessible by anon user" do
        before { visit playlists_path }
        it { should_not have_text Playlist.last.name } 
      end
    end
  end
end
