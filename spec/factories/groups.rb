FactoryBot.define do
  factory :group do
    name { Faker::Color.color_name }
  end
end
