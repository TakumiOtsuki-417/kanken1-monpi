class ApplicationController < ActionController::Base
  before_action :confirm_signed_in, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_codes, if: :devise_controller?
  private

  def confirm_signed_in
    unless user_signed_in? || admin_signed_in? || controller_name == "helps"
      redirect_to new_user_session_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :rank, :code1, :code2, :code3, :code4])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:code1, :code2, :code3, :code4])
  end

  def configure_codes
    if 
      @user = User.new(permitted_parameters)
      unless @user.valid?
        flash.now[:alert] = @user.errors.full_messages
        render :new and return
      end  end

end
