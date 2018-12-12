class UserMailer < ApplicationMailer

    def sign_in_mail(user_mail, user_nickname)
        @user_nickname = user_nickname
        mail(to: user_mail, subject: 'Bienvenue sur TableFinder!')
    end

    def emailtouser(sender_email, receiver_email, content, sendcopy)
        @content = content
        @sender_email = sender_email
        mail(to: receiver_email, subject: 'Admin TableFinder '+@sender_email)
        if sendcopy == 1
            mail(to: sender_email, subject: 'Copie du mail envoyé à '+ receiver_email)
        end
    end

    def unwantedemail(user_email)
        mail(to: user_email, subject: 'Admin TableFinder, comportement inaproprié')
    end

    def contact_us(current_user_id, emailcontent, sendcopy)
        @current_user = User.find(current_user_id)
        @emailcontent = emailcontent
        User.admin.each do |admin|
            mail(to: admin.email, subject: 'TableFinder demande utilisateur ' + @current_user.email)
        end

        User.webmaster.each do |webmaster|
            mail(to: webmaster.email, subject: 'TableFinder demande utilisateur ' + @current_user.email)
        end

        if sendcopy == 1
            mail(to: @current_user.email, subject: 'Copie du mail envoyé à TableFinder')
        end
    end
end
