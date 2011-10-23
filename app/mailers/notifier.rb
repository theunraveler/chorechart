class Notifier < ActionMailer::Base
  default :from => 'info@chorechartapp.com'

  def invite(email, group, inviter)
    @group = group
    @inviter = inviter
    mail(:to => email, :subject => "Join Chorechart!")
  end

end
