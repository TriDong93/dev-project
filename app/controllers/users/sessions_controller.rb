class Users::SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    user_username = params[:user][:username]
    user = User.find_by_username user_username

    if user.present?
      self.resource = warden.authenticate!(auth_options)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      create_user
    end
  end

  def create_user
    build_resource(sign_up_params)

    resource.save
    if resource.persisted?
      set_flash_message! :notice, :signed_up
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      flash[:notice] = flash[:notice].to_a.concat resource.errors.full_messages
      redirect_to root_path(resource)
    end
  end

  def sign_up_params
    params.require(:user).permit(:username, :password)
  end

  def sign_in_params
    params.require(:user).permit(:username, :password)
  end

  # def auth_options
  #   { scope: resource_name, recall: "pages#index" }
  # end

  def build_resource(hash = {})
    self.resource = resource_class.new_with_session(hash, session)
  end

  # The path used after sign up. You need to overwrite this method
  # in your own RegistrationsController.
  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource) if is_navigational_format?
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end