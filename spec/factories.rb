FactoryGirl.define do

factory :user do
  username 'test_user'
  password  'secure_password'
  email 'test@test.com'
  confirmed_at Time.now
end

end
