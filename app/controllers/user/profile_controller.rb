class User::ProfileController < User::BaseController
  
  # GET /profile
  def index
    @user = @current_user
  end 

  def edit
    @user = @current_user

    respond_to do |format|
      format.html { }
      format.json { render json: @user }
      format.js {}
    end
  end

  def update
    ## Fetching the user
    @user = @current_user

    ## Updating the @user object with params
    @user.assign_attributes(params[:user].permit(:name, :username, :email, :phone, :designation_overridden, :linkedin, :skype, :department_id, :designation_id))

    ## Validating the data
    @user.valid?

    respond_to do |format|
      if @user.errors.blank?

        # Saving the user object
        @user.save

        # Setting the flash message
        message = translate("forms.updated_successfully", :item => "User")
        store_flash_message(message, :success)

        format.html {
          redirect_to user_profile_path, notice: message
        }
        format.json { head :no_content }
        format.js {}

      else

        # Setting the flash message
        message = @user.errors.full_messages.to_sentence
        store_flash_message(message, :alert)

        format.html {
          render action: "edit"
        }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js {}

      end
    end
  end

  private
  
  def set_navs
    set_nav("user/profile")
  end
  
end

