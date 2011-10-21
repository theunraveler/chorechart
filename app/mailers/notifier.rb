class Notifier < ActionMailer::Base

  def invite(email, group, inviter)
    @group = group
    @inviter = inviter
    mail(:to => email, :subject => "Join Chorechart!", :from => 'info@chorechartapp.com')
  end

end
