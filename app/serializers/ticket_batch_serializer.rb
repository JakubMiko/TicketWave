# app/serializers/ticket_batch_serializer.rb
class TicketBatchSerializer
  include JSONAPI::Serializer

  attributes :available_tickets, :price, :sale_start, :sale_end

  belongs_to :event
end
