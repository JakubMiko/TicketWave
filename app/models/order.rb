class Order < ApplicationRecord
  belongs_to :user
  belongs_to :ticket_batch
  has_many :tickets, dependent: :destroy

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :total_price, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true

  def event
    ticket_batch.event
  end
end
