class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:new]

  def new
    event = Event.find(params[:event_id])
    ticket_batch = TicketBatch.find(params[:ticket_batch_id])
    order = Order.new

    user = user_signed_in? ? current_user : nil

    render :new, locals: {
      event: event,
      ticket_batch: ticket_batch,
      order: order,
      user: user
    }, status: :ok
  end

  def create
    ticket_batch = TicketBatch.find(params[:ticket_batch_id])
    event = ticket_batch.event

    quantity = order_params[:quantity].to_i

    if quantity <= 0
      redirect_to event_path(event), alert: "Nieprawidłowa liczba biletów."
      return
    end

    if quantity > ticket_batch.available_tickets
      redirect_to event_path(event), alert: "Nie ma wystarczającej liczby biletów. Dostępnych: #{ticket_batch.available_tickets}"
      return
    end

    order = Order.new(order_params)
    order.ticket_batch = ticket_batch
    order.total_price = ticket_batch.price * quantity
    order.status = "completed"

    if !user_signed_in? && params[:register] && params[:user].present?
      user_params = params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
      user = User.new(user_params)
      user.role = "user"

      if user.save
        sign_in(user)
        order.user = user
      else
        render :new, locals: { event: event, ticket_batch: ticket_batch, order: order, user: user }, status: :unprocessable_entity
        return
      end
    elsif user_signed_in?
      order.user = current_user
    else
      # Guest checkout
      if params[:guest_email].blank?
        redirect_to event_path(event), alert: "Podaj adres email lub zaloguj się."
        return
      end

      # Find or create guest user
      guest_user = User.find_or_initialize_by(email: params[:guest_email])
      if guest_user.new_record?
        guest_user.password = SecureRandom.hex(8)
        guest_user.first_name = params[:guest_first_name]
        guest_user.last_name = params[:guest_last_name]
        guest_user.role = "user"

        unless guest_user.save
          redirect_to event_path(event), alert: "Nie udało się utworzyć konta użytkownika."
          return
        end
      end

      order.user = guest_user
    end

    ActiveRecord::Base.transaction do
      if order.save
        ticket_batch.available_tickets -= quantity
        ticket_batch.save!

        quantity.times do
          ticket = Ticket.new(
            order: order,
            user: order.user,
            event: event,
            price: ticket_batch.price,
            ticket_number: "#{event.id}-#{SecureRandom.hex(4)}"
          )
          ticket.save!
        end

        redirect_to confirmation_order_path(order), notice: "Zamówienie zostało złożone pomyślnie."
      else
        render :new, locals: { event: event, ticket_batch: ticket_batch, order: order, user: nil }, status: :unprocessable_entity
      end
    end
  rescue ActiveRecord::RecordInvalid
    redirect_to event_path(event), alert: "Wystąpił błąd podczas przetwarzania zamówienia."
  end

  def confirmation
    order = Order.find(params[:id])

    if order.user != current_user
      redirect_to events_path, alert: "Nie masz dostępu do tego zamówienia."
      return
    end

    render :confirmation, locals: { order: order }, status: :ok
  end

  def index
    orders = current_user.orders.order(created_at: :desc)

    render :index, locals: { orders: orders }, status: :ok
  end

  def show
    order = Order.includes(:tickets).find(params[:id])

    if order.user != current_user
      redirect_to orders_path, alert: "Nie masz dostępu do tego zamówienia."
      return
    end

    render :show, locals: { order: order }, status: :ok
  end

  private

  def order_params
    params.require(:order).permit(:quantity)
  end
end