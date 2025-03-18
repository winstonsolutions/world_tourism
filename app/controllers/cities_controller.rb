class CitiesController < ApplicationController
  def index
    @country = Country.find(params[:country_id])
    @cities = @country.cities.order(:name).page(params[:page]).per(10)
  end

  def show
    @city = City.find(params[:id])
    @attractions = @city.attractions.order(:name).page(params[:page]).per(5)
  end
end