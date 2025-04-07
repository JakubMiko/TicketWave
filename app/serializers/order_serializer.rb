class OrderSerializer
  include JSONAPI::Serializer

  attributes :created_at, :status, :total_price, :quantity

  attribute :user do |order|
    {
      id: order.user.id,
      email: order.user.email,
      first_name: order.user.first_name,
      last_name: order.user.last_name
    }
  end

  attribute :ticket_batch do |order|
    {
      id: order.ticket_batch.id,
      available_tickets: order.ticket_batch.available_tickets,
      price: order.ticket_batch.price
    }
  end

  attribute :event do |order|
    {
      id: order.ticket_batch.event.id,
      name: order.ticket_batch.event.name
    }
  end
end