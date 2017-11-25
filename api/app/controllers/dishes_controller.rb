class DishesController < ApplicationController
  def create
    rebuild_params
    super
  end

  private

  def rebuild_params
    params[:data][:relationships] = build_restaurant_relationship
    params.require(:data)
          .require(:relationships)
          .require(:restaurant)
          .require(:data)
          .permit(:id)
  end

  def build_restaurant_relationship
    {
      restaurant: { data: { type: 'restaurants', id: params[:restaurant_id] } }
    }
  end
end
