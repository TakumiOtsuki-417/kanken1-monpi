class ApplicationController < ActionController::Base
  before_action :confirm_signed_in, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def confirm_signed_in
    unless user_signed_in? || admin_signed_in? || controller_name == "sessions" || controller_name == "helps"
        redirect_to new_user_session_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :rank_id, :code1, :code2, :code3, :code4])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:code1, :code2, :code3, :code4])
    if request.fullpath == "/admins/sign_in" && !params[:admin].nil?
      code1 = params[:admin][:code1]
      code2 = params[:admin][:code2]
      code3 = params[:admin][:code3]
      code4 = params[:admin][:code4]
      codes = [code1, code2, code3, code4]
      corrects = [ENV['MONPI_ADMIN_AUTH_CODE1'], ENV['MONPI_ADMIN_AUTH_CODE2'], ENV['MONPI_ADMIN_AUTH_CODE3'], ENV['MONPI_ADMIN_AUTH_CODE4']]
      correct_flag = true
      4.times do |i|
        if codes[i] != corrects[i]
          correct_flag = false
        end
      end
      if !correct_flag
        flash.now[:alert] = "ログイン情報が間違っています"
        render :new
      end
    end

  end


end
