FactoryGirl.define do
  factory :record do |f|
    f.url{Faker::Internet.url}
    f.content{Faker::Lorem.paragraph}
    f.link{[Faker::Internet.url, Faker::Internet.url, Faker::Internet.url, Faker::Internet.url]}
  end
end


