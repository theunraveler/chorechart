Before('@omniauth') do
  OmniAuth.config.test_mode = true

  [:facebook, :github].each do |service|
    OmniAuth.config.mock_auth[service] = {
      'provider' => service.to_s,
      'uid' => '12345',
      'user_info' => { 'email' => 'test@test.com', 'nickname' => "test_#{service.to_s}_user", 'name' => "#{service.to_s.capitalize} User" }
    }
  end

  # Do twitter separately because the don't send an email back.
  OmniAuth.config.mock_auth[:twitter] = {
    'provider' => 'twitter',
    'uid' => '12345',
    'user_info' => { 'nickname' => 'test_twitter_user', 'name' => 'Twitter User' }
  }
end

After('@omniauth') do
  OmniAuth.config.test_mode = false
end
