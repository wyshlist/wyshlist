class UserMailer < ApplicationMailer 
  def signup_email
    @user = params[:user] 
    mail(to: @user.email, subject: 'Welcome! We have a gift for you') 
  end 
end