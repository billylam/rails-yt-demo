require 'spec_helper'

describe "StaticPages" do
  before { visit root_path }
  subject { page }
  describe "HomePage" do
    it { should have_link "About" }
    it { should have_link "Blog" }
    it { should have_link "Playlists" }
    it { should have_link "Videos" }
    it { should have_link "+New List" }
    it { should have_link "playlister.herokuapp.com" }
  end
end
