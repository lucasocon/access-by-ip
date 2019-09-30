class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :authenticate_ip_addreess

  def authenticate_active_admin_user!
    if current_user.company.responsible_id != current_user.id
      flash[:alert] = "Unauthorized Access!"
      redirect_to root_path
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    current_user.company.responsible_id == current_user.id ? admin_root_path : root_path
  end

  def authenticate_ip_addreess
    if current_user && current_user.company.responsible_id != current_user.id
      result = IpAuthenticatorService.new(current_user, request).call
      return true if result

      sign_out current_user
      redirect_to user_session_path, notice: 'You cannot access from your ip'
    end
  end
end
