class Event < ApplicationRecord
  has_many :ticket_batches, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_one_attached :image

  enum :category, {
    music: "music",
    theater: "theater",
    sports: "sports",
    comedy: "comedy",
    conference: "conference",
    festival: "festival",
    exhibition: "exhibition",
    other: "other"
  }

  def past_event?
    date < DateTime.now
  end

  def editable?
    !past_event?
  end
end
