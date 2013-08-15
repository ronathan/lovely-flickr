class UserMailer < ActionMailer::Base
  default from: "ronald@lovely-flicker.com"

  def confirm_email(user)
  	@user = user
  	mail(to: @user.email, subject: 'Confirm your e-mail for Lovely Flickr')
  end

  def create_photo(user)
  	@user = user
  	mail(to: @user.email, subject: 'You just uploaded a new photo!')
  end
  
end