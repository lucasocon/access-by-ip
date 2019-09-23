class Ip < ActiveRecord::Base
  belongs_to :whitelist

  validates_presence_of :address

  validate :valid_ip, on: [:create, :update]

  private

  def valid_ip
    errors.add(:address, "invalid ip address") if (IPAddr.new(str) rescue nil).nil?
  end
end
