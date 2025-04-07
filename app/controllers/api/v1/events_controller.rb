class Api::V1::EventsController < Api::V1::BaseController
  def index
    @events = Event.all
    render json: EventSerializer.new(@events).serializable_hash.to_json
  end

  def show
    @event = Event.find(params[:id])
    render json: EventSerializer.new(@event).serializable_hash.to_json
  end

  def ticket_availability
    @event = Event.find(params[:id])

    batch_details = @event.ticket_batches.map do |batch|
      {
        id: batch.id,
        # usuwam name, bo nie istnieje w modelu
        available_count: batch.available_tickets, # zmiana z available_count na available_tickets
        price: batch.price,
        sale_start: batch.sale_start,
        sale_end: batch.sale_end
        # usuwam total_count, bo nie istnieje w modelu
      }
    end

    render json: {
      data: {
        id: @event.id,
        type: "ticket_availability",
        attributes: {
          event_name: @event.name,
          event_id: @event.id,
          total_available_tickets: @event.ticket_batches.sum(&:available_tickets), # zmiana z available_count na available_tickets
          ticket_batches: batch_details
        }
      }
    }
  end
end
