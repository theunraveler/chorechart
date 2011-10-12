FactoryGirl.define do

factory :user do
  username 'test_user'
  password  'secure_password'
  email 'test@test.com'
end

factory :group do
  name 'A New Group'
end

factory :membership do
end

end
