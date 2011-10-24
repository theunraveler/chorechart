FactoryGirl.define do

factory :user do
  username 'test_user'
  password  'secure_password'
  email 'test@test.com'
end

factory :group do
  name 'A New Group'
end

factory :chore do
end

factory :membership do
end

factory :invitation do
end

end
