Before('@omniauth') do
  OmniAuth.config.test_mode = true

  # the symbol passed to mock_auth is the same as the name of the provider set up in the initializer
  OmniAuth.config.mock_auth[:facebook] = {
    'provider' => 'facebook',
    'uid' => '12345',
  }
end

After('@omniauth') do
  OmniAuth.config.test_mode = false
end
