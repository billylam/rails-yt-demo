FactoryGirl.define do
  factory :video do
    #name: Daft Punk - Get Lucky (Official Audio) ft. Pharrell Williams 
    url "http://www.youtube.com/watch?v=5NV6Rdv1a3I"
  end

  factory :user do
    sequence(:username) { |n| "User#{n}" }
    sequence(:email) { |n| "foo#{n}@bar.com" }
  end

  #note - remember associated model for pl factories
  factory :playlist do
    sequence(:name) { |n| "Playlist #{n}" }
    user
    after(:create) do |playlist|
      playlist.videos << FactoryGirl.create(:video)
    end
  end
end
