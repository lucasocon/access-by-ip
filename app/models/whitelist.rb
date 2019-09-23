class Whitelist < ActiveRecord::Base
  belongs_to :company
  has_many :ips, dependent: :destroy

  validates_presence_of :company, :name, :ips

  accepts_nested_attributes_for :ips, reject_if: :all_blank, allow_destroy: true

  validates_associated :ips, on: [:create, :update]
end
