class AttractionsController < ApplicationController
  def index
    @city = City.find(params[:city_id])
    @attractions = @city.attractions.order(:name).page(params[:page]).per(9)
  end

  def show
    @attraction = Attraction.find(params[:id])
  end
end