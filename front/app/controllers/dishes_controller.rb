class DishesController < ApplicationController
  before_action :set_dish, only: [:show, :edit, :update, :destroy]

  # GET /dishes
  # GET /dishes.json
  def index
    @restaurant = Restaurant.find(restaurant_id)
    @dishes = Dish.where(restaurant_id: restaurant_id).all
  end

  # GET /dishes/1
  # GET /dishes/1.json
  def show
  end

  # GET /dishes/new
  def new
    @dish = Dish.new
  end

  # GET /dishes/1/edit
  def edit
  end

  # POST /dishes
  # POST /dishes.json
  def create
    @dish = Dish.create(dish_params.merge(restaurant_id: restaurant_id))

    if @dish.valid?
      redirect_to restaurant_dishes_path, notice: 'Dish was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /dishes/1
  # PATCH/PUT /dishes/1.json
  def update
    if @dish.update(dish_params)
      redirect_to @dish, notice: 'Dish was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /dishes/1
  def destroy
    @dish.destroy
    redirect_to dishes_url, notice: 'Dish was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dish
      @restaurant = Restaurant.find(restaurant_id).first
      @dish = Dish.where(restaurant_id: restaurant_id).find(dish_id).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dish_params
      params.require(:dish).permit!
    end

    def restaurant_id
      params[:restaurant_id]
    end

    def dish_id
      params[:id]
    end
end
