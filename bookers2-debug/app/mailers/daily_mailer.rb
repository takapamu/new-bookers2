class DailyMailer < ApplicationMailer
    def daily_mail
        default to: -> { User.pluck(:email) }
        mail(subject: "everyday Bookers!yay!")
    end
 
end
