Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :facebook, '248161658559115', 'a4c0fc2fb9715ca45d0723a00d731e83'  
  provider :openid, nil, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :twitter, 'yRiRTLQtAqjCB63TTIXRuw', 'NqgeZTwrfwGx2MU4tUoRn67jhB7zJquP5b9Ixy8PU'
end