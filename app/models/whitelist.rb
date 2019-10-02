class Whitelist < ActiveRecord::Base
  belongs_to :company
  has_many :ips, dependent: :destroy

  validates_presence_of :company, :name, :ips

  accepts_nested_attributes_for :ips, reject_if: :all_blank, allow_destroy: true

  validates_associated :ips, on: %i[create update]

  validate :only_one_whitelist_by_company, on: %i[create]
  validate :uniques_ip, on: %i[create update]

  private

  def uniques_ip
    addresses = ips.map { |ip| ip.address }
    if addresses.uniq.length != addresses.length
      errors.add(:whitelist, 'There are duplicate ips')
    end
  end

  def only_one_whitelist_by_company
    if Whitelist.where(company_id: company_id).size > 0
      errors.add(:whitelist, 'The Company already has a whitelist registered')
    end
  end
end
