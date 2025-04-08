class Event < ApplicationRecord
  has_many :ticket_batches, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_one_attached :image

  enum :category, {
    music: "muzyka",
    theater: "teatr",
    sports: "sport",
    comedy: "komedia",
    conference: "konferencja",
    festival: "festiwal",
    exhibition: "wystawa",
    other: "inne"
  }

  def past_event?
    date < DateTime.now
  end

  def editable?
    !past_event?
  end
end
