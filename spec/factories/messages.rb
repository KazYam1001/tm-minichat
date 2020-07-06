FactoryBot.define do
  factory :message do
    content { Faker::Lorem.sentence }
    group
  end
end
