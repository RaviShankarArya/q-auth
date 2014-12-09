class Admin::UsersController < Admin::BaseController

  #authorize_actions_for Item, :actions => {:index => :delete}
  before_filter :get_user, :only => [:masquerade]

  # GET /users
  # GET /users.js
  # GET /users.json
  def index

    get_collections

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
      format.js {}
    end
  end

  # GET /users/1
  # GET /users/1.js
  # GET /users/1.json
  def show
    ## Creating the user object
    @user = User.find(params[:id])

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @user }
      format.js {}
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    ## Intitializing the user object
    @user = User.new

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @user }
      format.js {}
    end
  end

  # GET /users/1/edit
  def edit
    ## Fetching the user object
    @user = User.find(params[:id])

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @user }
      format.js {}
    end
  end

  # POST /users
  # POST /users.js
  # POST /users.json
  def create
    ## Creating the user object
    @user = User.new(user_params)
    @user.password = ConfigCenter::Defaults::PASSWORD
    @user.password_confirmation = ConfigCenter::Defaults::PASSWORD
    ## Validating the data
    @user.valid?

    respond_to do |format|
      if @user.errors.blank?

        # Saving the user object
        @user.save

        # Setting the flash message
        message = translate("forms.created_successfully", :item => "User")
        store_flash_message(message, :success)

        format.html {
          redirect_to user_dashboard_url, notice: message
        }
        format.json { render json: @user, status: :created, location: @user }
        format.js {}
      else

        # Setting the flash message
        message = @user.errors.full_messages.to_sentence
        store_flash_message(message, :alert)

        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.js
  # PUT /users/1.json
  def update
    ## Fetching the user
    @user = User.find(params[:id])

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
          redirect_to user_dashboard_url, notice: message
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

  # DELETE /users/1
  # DELETE /users/1.js
  # DELETE /users/1.json
  def destroy
    ## Fetching the user
    @user = User.find(params[:id])

    respond_to do |format|
      ## Destroying the user
      @user.destroy
      @user = User.new

      # Fetch the users to refresh ths list and details box
      get_collections
      @user = @users.first if @users and @users.any?

      # Setting the flash message
      message = translate("forms.destroyed_successfully", :item => "User")
      store_flash_message(message, :success)

      format.html {
        redirect_to user_dashboard_url notice: message
      }
      format.json { head :no_content }
      format.js {}

    end
  end

   def masquerade
    if ["development", "it", "test"].include?(Rails.env)
      message = translate("users.masquerade", user: @users_masq.name)
      session[:last_user_id] = current_user.id
      session[:id] = @users_masq.id
      redirect_to user_dashboard_path
    end
  end

  private

  def set_navs
    set_nav("admin/users")
  end

  def get_collections
    # Fetching the users
    relation = User.where("")
    @filters = {}
    if params[:query]
      @query = params[:query].strip
      relation = relation.search(@query) if !@query.blank?
    end

    @per_page = params[:per_page] || "20"
    @users = relation.order("name asc").page(@current_page).per(@per_page)

    ## Initializing the @user object so that we can render the show partial
    @user = @users.first unless @user

    return true

  end

  def get_user
    @users_masq = User.find(params[:id]) if params[:id]
    @users_masq = User.find(params[:user_id]) if params[:user_id]
  end

  def user_params
    params.require(:user).permit(:name, :username, :email, :phone, :designation_overridden, :linkedin, :skype, :department_id, :designation_id)
  end

end
