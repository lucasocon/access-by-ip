class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :authenticate_ip_addreess

  def authenticate_active_admin_user!
    unless Company.find_by(responsible_id: current_user.id)
      flash[:alert] = "Unauthorized Access!"
      redirect_to root_path
    end
  end

  def authenticate_ip_addreess
    if current_user
      user_ip = IPAddr.new(request.remote_ip)
      # An array of IPs should be allowed. Stored on the company.
      allowed_ips = current_user.company.whitelist.ips unless Company.find_by(responsible_id: current_user.id)

      # Validate IP only if allowed_ips array is set, otherwise there is no IP restriction
      if allowed_ips && !allowed_ips.empty?
        verified = false

        allowed_ips.each do |allowed_ip|
          allowed_ip = IPAddr.new(allowed_ip.address)
          verified = true if allowed_ip.include?(user_ip)
        end

        # Redirect back to main page if not verified
        unless verified
          sign_out current_user
          redirect_to user_session_path, notice: "You cannot access from your ip"
        end
      end
    end
  end
end
