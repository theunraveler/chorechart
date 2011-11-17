class Authentication < ActiveRecord::Base
  belongs_to :user

  def provider_name  
    case provider
      when 'google_oauth2'
        'Google'
      else  
        provider.titleize  
    end  
  end  
end
