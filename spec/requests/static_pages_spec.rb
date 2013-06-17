require 'spec_helper'

describe "StaticPages" do
  before { visit root_path }
  subject { page }
  describe "HomePage" do
    it { should have_link "About" }
    it { should have_link "Contact" }
    it { should have_link "Blog" }
    it { should have_link "New Playlist" }
    it { should have_link "Browse Playlists" }
    it { should have_link "Sign In" }
    it { should have_link "Register" }
    it { should have_link "Playlister" }
  end
end
