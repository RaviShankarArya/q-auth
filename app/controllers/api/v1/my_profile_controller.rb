module Api
  module V1
    class MyProfileController < Api::V1::BaseController

      def update

        proc_code = Proc.new do

          @user = current_user
          @user.assign_attributes(user_params)
          if @user.valid?
            @user.save
            @data = @user
            @alert = I18n.translate("registration.success")
          else
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
        params.require(:user).permit(:name, :biography, :password, :password_confirmation)
      end

    end
  end
end
