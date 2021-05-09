class ThanksMailer < ApplicationMailer
  
  def complete_registration(user)
    @user = user
    mail(:subject => "登録完了のお知らせ", to: 'takapamukyary0129@gmail.com')
  end
end
