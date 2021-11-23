class UserMailer < ApplicationMailer
  def confirm_email
    @user = params[:user]
    mail(to: @user.email_address, subject: "Confirm your email address") # TODO localize subject
    @user.email_confirmation_sent_at = Time.now
    @user.save!
  end
end
