require 'spec_helper'

describe Editorship do
  let(:user) { FactoryGirl.create(:user) }
  let(:editor) { FactoryGirl.create(:user) }
  let(:editorship) { follower.editorships.build(editor_id: editor.id) }

  subject { relationship }

  it { should be_valid }
end
