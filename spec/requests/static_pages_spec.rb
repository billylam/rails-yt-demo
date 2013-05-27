require 'spec_helper'

describe "StaticPages" do
  subject { page }
  describe "HomePage" do
    it { should have_selector('p', 'About') }
    it { should have_selector('p', 'Blog') }
  end
end
