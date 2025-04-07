class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_create :generate_api_token

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tickets
  has_many :orders


  enum :role, {
    admin: "admin",
    user: "user"
  }, default: :user


  def self.human_attribute_name(attribute, options = {})
    ""
  end

  def regenerate_api_token
    update(api_token: generate_token)
  end

  private

  def generate_api_token
    self.api_token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(32)
      break token unless User.where(api_token: token).exists?
    end
  end
end
