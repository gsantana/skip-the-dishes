class DishesController < ApplicationController
  def create
    dish = Dish.create(dish_params)
    if dish.persisted?
      render json: serialize(dish), status: :created
    else
      render json: { errors: dish.errors }, status: :unprocessable_entity
    end
  end

  private

  def dish_params
    params[:data][:attributes].permit!
  end

  def serialize(dish)
    JSONAPI::ResourceSerializer.new(DishResource)
      .serialize_to_hash(DishResource.new(dish, nil))
  end
end
