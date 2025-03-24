class TicketBatchesController < ApplicationController
  def new
    event = Event.find(params[:event_id])
    ticket_batch = TicketBatch.new(event: event)

    render :new, locals: { event: event, ticket_batch: ticket_batch }, status: :ok
  end

  def create
    event = Event.find(params[:event_id])
    ticket_batch = event.ticket_batches.new(ticket_batch_params)
    if ticket_batch.save
      redirect_to event_path(event), notice: "Pula biletów została dodana."
    else
      render :new, locals: { event: event, ticket_batch: ticket_batch }, status: :unprocessable_entity
    end
  end

  def edit
    event = Event.find(params[:event_id])
    ticket_batch = event.ticket_batches.find(params[:id])
    render :edit, locals: { event: event, ticket_batch: ticket_batch }
  end

  def update
    event = Event.find(params[:event_id])
    ticket_batch = event.ticket_batches.find(params[:id])
    if ticket_batch.update(ticket_batch_params)
      redirect_to event_path(event), notice: "Pula biletów została zaktualizowana."
    else
      render :edit, locals: { event: event, ticket_batch: ticket_batch }, status: :unprocessable_entity
    end
  end

  def destroy
    event = Event.find(params[:event_id])
    ticket_batch = event.ticket_batches.find(params[:id])
    ticket_batch.destroy
    redirect_to event_path(event), notice: "Pula biletów została usunięta."
  end

  private

  def ticket_batch_params
    params.require(:ticket_batch).permit(:available_tickets, :price, :sale_start, :sale_end)
  end
end
