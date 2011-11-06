Before('@omniauth') do
  OmniAuth.config.test_mode = true

  [:facebook, :github, :google_oauth2].each do |service|
    OmniAuth.config.mock_auth[service] = {
      'provider' => service.to_s,
      'uid' => '12345',
      'info' => { 'email' => 'test@test.com', 'nickname' => "test_#{service.to_s}_user", 'name' => "#{service.to_s.capitalize} User" }
    }
  end

  # Do twitter separately because the don't send an email back.
  OmniAuth.config.mock_auth[:twitter] = {
    'provider' => 'twitter',
    'uid' => '12345',
    'info' => { 'nickname' => 'test_twitter_user', 'name' => 'Twitter User' }
  }

  OmniAuth.config.mock_auth[:google_oauth2] = {
    'provider' => 'google_oauth2',
    'uid' => 'test@test.com',
    'info' => { 'name' => 'Twitter User', 'email' => 'test@test.com' }
  }
end

After('@omniauth') do
  OmniAuth.config.test_mode = false
end
