class Order < ApplicationRecord
  belongs_to :user
  belongs_to :ticket_batch
  has_many :tickets
end
