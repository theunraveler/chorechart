class Authentication < ActiveRecord::Base
  belongs_to :user

  def to_s
    case provider
    when 'google_oauth2'
      'Google'
    else
      provider.titleize
    end
  end
end
