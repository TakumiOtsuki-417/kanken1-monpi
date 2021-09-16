# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  protect_from_forgery
  # def new
  #   super
  #   @admin = Admin.new(configure_sign_in_params)
  # end

  def create
    @admin = Admin.find_by(email: params[:admin][:email])
    binding.pry
    if @admin
      if @admin.encrypted_password == params[:admin][:encrypted_password]
        sign_in(@admin)
        redirect_to root_path
      end
    end
      flash.now[:alert] = "ログイン情報が間違っています"
      redirect_to new_admin_session_path
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    params.require(:admin).permit(:email, :password, :code1, :code2, :code3, :code4)
  end
end
