FactoryGirl.define do
  factory :video do
    #should be from a random set...
    youtube_id "5NV6Rdv1a3I"
    #rating - generate random float from 1-5
    #rand * range + offset
    rating 4.9 #(rand * 4 + 1)
  end

  factory :user do
    sequence(:username) { |n| "User#{n}" }
    sequence(:email) { |n| "foo#{n}@bar.com" }
  end

  #note - remember associated model for pl factories
  factory :playlist do
    sequence(:name) { |n| "Playlist #{n}" }
    user
  end
end
