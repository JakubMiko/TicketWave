class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tickets
  has_many :orders


  enum :role, {
    admin: "admin",
    user: "user"
  }


  def self.human_attribute_name(attribute, options = {})
    ""
  end
end
