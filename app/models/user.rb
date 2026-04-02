class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :province, optional: true
  has_many :orders

  def admin?
    role == "admin"
  end

  def address_complete?
    address.present? &&
    city.present? &&
    postal_code.present? &&
    province_id.present?
  end
end
