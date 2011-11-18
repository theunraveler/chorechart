FactoryGirl.define do

factory :user do
  name { Faker::Name.name }
  username { Faker::Internet.user_name(name) }
  password 'secure_password'
  email { Faker::Internet.email(name) }
end

factory :group do
  name { Faker::Lorem.words(2).join(' ') }
end

factory :chore do
  association :group
  name { Faker::Lorem.words(3).join(' ') }
  difficulty 1
end

factory :membership do
  association :user
  association :group
end

factory :invitation do
  association :group
  email { Faker::Internet.email }
end

factory :authentication do
  association :user
  provider 'twitter'
end

end
