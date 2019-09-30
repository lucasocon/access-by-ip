class Company < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_one :whitelist

  belongs_to :responsible, class_name: 'User', foreign_key: :responsible_id

  validates_presence_of :name
  validates :timezone, inclusion: ActiveSupport::TimeZone.zones_map.values.map { |e| e.name }

  enum customers_type: {
    regular_customers: 'regular',
    fund_customers: 'funds',
    entity_customers: 'entities',
  }

  alias :has_funds? :fund_customers?
  alias :has_entities? :entity_customers?
  alias :has_clients? :regular_customers?

  alias :has_funds :has_funds?
end
