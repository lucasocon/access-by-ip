class IpAuthenticatorService
  def initialize(user, remote_ip)
    @user = user
    @remote_ip = remote_ip
  end

  def call
    return true unless @user.company.whitelist

    user_ip = IPAddr.new(@remote_ip)
    # An array of IPs should be allowed. Stored on the company.
    allowed_ips = @user.company_whitelist_ips

    # Validate IP only if allowed_ips array is set, otherwise there is no IP restriction
    if allowed_ips && !allowed_ips.empty?
      allowed_ips.each do |allowed_ip|
        return true if IPAddr.new(allowed_ip.address).include?(user_ip)
      end
    end

    false
  end
end
