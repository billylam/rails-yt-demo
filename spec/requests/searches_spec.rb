require 'spec_helper'

describe "Playlists" do
  before do 
    @user = FactoryGirl.create(:user)
    @playlist = FactoryGirl.create(:playlist)
    visit search_path
  end

  subject { page }

  describe "Search too short" do
    before do
      fill_in "Search", with: "a"
      click_button "Search"
    end

    it { should have_text "Minimum search length is 3." }
  end

  describe "User found" do
    before do
      fill_in "Search", with: @user.username
      click_button "Search"
    end

    it { should have_text @user.username }
  end

  describe "Playlist found" do
    before do
      fill_in "Search", with: @playlist.name
      click_button "Search"
    end

    it { should have_text @playlist.name }
  end

  describe "Nothing found" do
    before do
      fill_in "Search", with: "This shouldn't match anything."
      click_button "Search"
    end

    it { should have_text "No match results" }
  end
end
