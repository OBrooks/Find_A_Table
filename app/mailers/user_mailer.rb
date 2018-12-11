class UserMailer < ApplicationMailer

    def sign_in_mail(user_mail, user_nickname)
        @user_nickname = user_nickname
        mail(to: user_mail, subject: 'Bienvenue sur TableFinder!')
    end
end
