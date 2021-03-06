class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable, 
         :recoverable, :rememberable, :validatable, :timeoutable

  belongs_to :company

  validates_presence_of :company

  delegate :whitelist_ips, prefix: :company, to: :company

  def full_name
    "#{first_name} #{last_name}"
  end
end
