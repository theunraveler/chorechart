FactoryGirl.define do

factory :user do
  name { Faker::Name.name }
  username { Faker::Internet.user_name(name) }
  password  'secure_password'
  email { Faker::Internet.email(name) }
end

factory :group do
  name 'A New Group'
end

factory :chore do
  difficulty 1
end

factory :membership do
end

factory :invitation do
end

end
