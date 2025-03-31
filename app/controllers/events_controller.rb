class EventsController < ApplicationController
  def index
    events = Event.all

    render :index, locals: { events: events }, status: :ok
  end

  def show
    event = Event.includes(:ticket_batches).find(params[:id])

    if event
      render :show, locals: { event: event }, status: :ok
    else
      render :not_found, status: :not_found
    end
  end

  def new
    event = Event.new

    render :new, locals: { event: event }, status: :ok
  end


  def create
    event = Event.new(event_params)

    if event.save
      redirect_to events_path, notice: "Wydarzenie zostało dodane."
    else
      render :new, locals: { event: event }, status: :unprocessable_entity
    end
  end

  def edit
    event = Event.find(params[:id])

    if event
      render :edit, locals: { event: event }, status: :ok
    else
      render :not_found, status: :not_found
    end
  end

  def update
    event = Event.find_by(id: params[:id])

    if event
      if event.update(event_params)
        redirect_to events_path, notice: "Wydarzenie zostało zaktualizowane."
      else
        render :edit, locals: { event: event }, status: :unprocessable_entity
      end
    else
      render :not_found, status: :not_found
    end
  end

  def destroy
    event = Event.find_by(id: params[:id])

    if event
      event.destroy
      redirect_to events_path, notice: "Wydarzenie zostało usunięte."
    else
      render :not_found, status: :not_found
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :place, :date, :category)
  end
end
