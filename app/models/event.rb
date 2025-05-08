class Event < ApplicationRecord
  has_many :ticket_batches, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_one_attached :image

  scope :upcoming, -> { where("date > ?", DateTime.now).order(date: :asc) }
  scope :past, -> { where("date <= ?", DateTime.now).order(date: :desc) }

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

  def past?
    date <= DateTime.now
  end
end
