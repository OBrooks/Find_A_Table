class HandleuserController < ApplicationController

    def webmaster
        @users = User.all
        if current_user.webmaster?
        else
          redirect_to root_path
        end
    end
  
    def admin
        @users = User.all
        if current_user.admin?
        else
            redirect_to root_path
        end
    end

    def scrapping
        Gamescrap.new.perform
    end

    def superpost
        if params[:admintonormaluser]
            User.find(params[:admintonormaluser]).peasant!
            if current_user.admin?
                redirect_back(fallback_location: admin_path)
            else 
                redirect_back(fallback_location: webmaster_path)
            end
        end
        
        if params[:usertounwanted]
            @unwanted_user = User.find(params[:usertounwanted])
            @unwanted_user.unwanted!
            UserMailer.unwantedemail(@unwanted_user.email).deliver_later
            if current_user.admin?
                redirect_back(fallback_location: admin_path)
            else 
                redirect_back(fallback_location: webmaster_path)
            end
        end

        if params[:normalusertoadmin]
            User.find(params[:normalusertoadmin]).admin!
            if current_user.admin?
                redirect_back(fallback_location: admin_path)
            else 
                redirect_back(fallback_location: webmaster_path)
            end
        end

        if params[:deleteaccount]
            User.find(params[:deleteaccount]).destroy
            if current_user.admin?
                redirect_back(fallback_location: admin_path)
            else 
                redirect_back(fallback_location: webmaster_path)
            end
        end
    end

    def emailuser
        if current_user.webmaster? || current_user.admin?
        else
          redirect_to root_path
        end
    end

    def sendemail
        @receiver_email = User.find(params[:receiver_id]).email
        UserMailer.emailtouser(current_user.email, @receiver_email, params[:content], params[:accept]).deliver_later
        if current_user.admin?
            redirect_to admin_path
        else 
            redirect_to webmaster_path
        end
    end

    def contact_us
    end

    def mail_us
        UserMailer.contact_us(current_user.id, params[:content], params[:accept]).deliver_later
        redirect_to root_path
    end
 
end
