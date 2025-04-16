class EventSerializer
  include JSONAPI::Serializer

  attributes :name, :description, :place, :date, :category

  # Instead of has_many :ticket_batches
  attribute :ticket_batches do |event|
    event.ticket_batches.map do |batch|
      {
        id: batch.id,
        available_tickets: batch.available_tickets,
        price: batch.price,
        sale_start: batch.sale_start,
        sale_end: batch.sale_end
      }
    end
  end
end
