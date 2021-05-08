class WelcomeMailer < ApplicationMailer
     default from: 'notifications@example.com'

 def welcome_email
     @user = params[:user]
     mail(to: @user.email, subject: '会員登録が完了しました')
 end
end
