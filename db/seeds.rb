# db/seeds.rb

# Uncomment the following line if you want to clean the database before seeding
# Ticket.delete_all
# Order.delete_all
# TicketBatch.delete_all
# Event.delete_all
# User.delete_all

admin = User.create!(first_name: "Admin", last_name: "User", email: "admin@gmail.com", password: "password", role: "admin")
regular_user = User.create!(first_name: "Regular", last_name: "User", email: "regular@gmail.com", password: "password", role: "user")

events = []
events << Event.create!(
  name: "Koncert XYZ",
  description: "Niesamowity koncert zespołu XYZ",
  place: "Arena Warszawa",
  date: (Time.now + 2.months).change(hour: 19, min: 0, sec: 0),
  category: "music"
)
events << Event.create!(
  name: "Premiera Sztuki ABC",
  description: "Poruszająca premiera w teatrze",
  place: "Teatr Narodowy",
  date: (Time.now + 1.month).change(hour: 18, min: 30, sec: 0),
  category: "theater"
)
events << Event.create!(
  name: "Mecz Piłki Nożnej Polska vs. Niemcy",
  description: "Emocjonujący mecz na stadionie",
  place: "Stadion Narodowy",
  date: (Time.now + 3.months).change(hour: 20, min: 0, sec: 0),
  category: "sports"
)

ticket_batches = []
events.each do |event|
  ticket_batches << TicketBatch.create!(
    event: event,
    available_tickets: rand(1..100),
    price: rand(50..200),
    sale_start: Time.now,
    sale_end: event.date - 1.day
  )
end

orders = []
ticket_batches.each do |ticket_batch|
  order1 = Order.create!(
    user: regular_user,
    ticket_batch: ticket_batch,
    quantity: 2,
    total_price: ticket_batch.price * 2,
    status: "paid"
  )
  orders << order1

  order2 = Order.create!(
    user: admin,
    ticket_batch: ticket_batch,
    quantity: 1,
    total_price: ticket_batch.price,
    status: "paid"
  )
  orders << order2
end


orders.each do |order|
  order.quantity.times do
    Ticket.create!(
      order: order,
      user: order.user,
      event: order.ticket_batch.event,
      price: order.ticket_batch.price,
      ticket_number: SecureRandom.hex(8)
    )
  end
end

puts "Seeds created successfully"
