FactoryBot.define do
  factory :share_video do
    association :user, factory: :user

    url { "http://www.youtube.com/watch?v=0zM3nApSvMg" }
  end
end
