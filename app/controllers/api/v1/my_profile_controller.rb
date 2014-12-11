module Api
  module V1
    class MyProfileController < Api::V1::BaseController

      def my_profile
        proc_code = Proc.new do

          if @current_user
            @data = @current_user
          else
            @success = false
            @alert = I18n.translate("response.authentication_error")
            raise AuthenticationError
          end
        end
        render_json_response(proc_code)
      end

      def update

        proc_code = Proc.new do

          @user = current_user
          @user.assign_attributes(user_params)
          if params[:user][:designation]
            designation = Designation.find_by_title(params[:user][:designation])
            @user.designation = designation if designation
          end
          if params[:user][:department]
            department = Department.find_by_name(params[:user][:department])
            @user.department = department if department
          end
          @user.password = params[:user][:password] if params[:user][:password]
          @user.password_confirmation = params[:user][:password_confirmation] if params[:user][:password_confirmation]

          if @user.valid?
            @user.save
            @data = @user
            @alert = I18n.translate("registration.success")
          else
            @success = false
            @alert = I18n.translate("response.validation_error")
            @errors = @user.errors
            raise ValidationError
          end
        end
        render_json_response(proc_code)
      end


      def user_detail
        proc_code = Proc.new do
          @user = User.find_by_auth_token(params[:auth_token])
          if @user.valid?
            @data = @user
          end
        end
        render_json_response(proc_code)
      end

      def user_params
        params.require(:user).permit(:name, :username, :phone, :skype, :linkedin, :city, :state, :country, :biography)
      end

    end
  end
end
