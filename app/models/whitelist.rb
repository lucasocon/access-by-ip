class Whitelist < ActiveRecord::Base
  belongs_to :company
  has_many :ips, dependent: :destroy

  validates_presence_of :company, :name, :ips

  accepts_nested_attributes_for :ips, reject_if: :all_blank, allow_destroy: true

  validates_associated :ips, on: [:create, :update]

  validate :only_one_whitelist_by_company, on: [:create, :update]

  private

  def only_one_whitelist_by_company
    errors.add(:whitelist, "The Company already has a whitelist registered") unless Company.find(self.company.id).whitelist.nil?
  end
end
