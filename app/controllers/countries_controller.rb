class CountriesController < ApplicationController
  def index
    @countries = Country.order(:name).page(params[:page]).per(10)
  end

  def show
    @country = Country.find(params[:id])
    @cities = @country.cities.order(:name).page(params[:page]).per(5)
  end
end