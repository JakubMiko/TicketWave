class Api::V1::OrdersController < Api::V1::BaseController
  before_action :authenticate_api_user!

  def index
    @orders = current_user.orders
    render json: OrderSerializer.new(@orders).serializable_hash.to_json
  end
end
