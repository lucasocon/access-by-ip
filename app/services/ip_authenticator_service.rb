class IpAuthenticatorService
  def initialize(user, request)
    @user = user
    @request = request
  end

  def call
    byebug
    user_ip = IPAddr.new(@request.remote_ip)
    # An array of IPs should be allowed. Stored on the company.
    allowed_ips = @user.company.whitelist.ips if @user.company.whitelist

    # Validate IP only if allowed_ips array is set, otherwise there is no IP restriction
    if allowed_ips && !allowed_ips.empty?
      verified = allowed_ips.each do |allowed_ip|
        break true if IPAddr.new(allowed_ip.address).include?(user_ip)
      end

      verified
    end
  end
end
