class CountriesController < ApplicationController
  def index
    @countries = Country.order(:name).page(params[:page]).per(6)
  end

  def show
    @country = Country.find(params[:id])
    @cities = @country.cities.order(:name).page(params[:page]).per(4)
  end
end