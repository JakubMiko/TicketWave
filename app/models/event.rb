class Event < ApplicationRecord
  has_many :ticket_batches
  has_many :tickets

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
end
