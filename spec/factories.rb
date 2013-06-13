FactoryGirl.define do
  factory :video do
    #name: Daft Punk - Get Lucky (Official Audio) ft. Pharrell Williams 
    url_raw "http://www.youtube.com/watch?v=5NV6Rdv1a3I"
  end

  factory :user do
    sequence(:username) { |n| "Username#{n}" }
    password "foobar1"
    password_confirmation "foobar1"
  end

  #note - remember associated model for pl factories
  factory :playlist do
    sequence(:name) { |n| "Playlist #{n}" }
    user
    after(:create) do |p|
      p.videos << FactoryGirl.create(:video)
    end
  end
end
