FactoryGirl.define do

factory :user do
  name { Faker::Name.name }
  username { Faker::Internet.user_name(name) }
  password  'secure_password'
  email { Faker::Internet.email(name) }
end

factory :group do
  name { Faker::Lorem.words(2) }
end

factory :chore do
  name { Faker::Lorem.words(3) }
  difficulty 1
end

factory :membership do
end

factory :invitation do
  email { Faker::Internet.email }
end

end
