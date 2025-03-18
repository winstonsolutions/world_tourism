class SearchController < ApplicationController
  def index
    @query = params[:query]
    @category = params[:category]
    
    if @query.present?
      # 基于类别的分层搜索
      case @category
      when 'countries'
        @results = Country.where("name LIKE ? OR continent LIKE ? OR language LIKE ?", 
                                  "%#{@query}%", "%#{@query}%", "%#{@query}%").page(params[:page]).per(10)
      when 'cities'
        @results = City.joins(:country)
                      .where("cities.name LIKE ? OR countries.name LIKE ?", 
                             "%#{@query}%", "%#{@query}%").page(params[:page]).per(10)
      when 'attractions'
        @results = Attraction.joins(city: :country)
                            .where("attractions.name LIKE ? OR attractions.description LIKE ?", 
                                   "%#{@query}%", "%#{@query}%").page(params[:page]).per(10)
      else
        # 默认搜索所有内容
        @countries = Country.where("name LIKE ? OR continent LIKE ? OR language LIKE ?", 
                                   "%#{@query}%", "%#{@query}%", "%#{@query}%").page(params[:page]).per(3)
        @cities = City.where("name LIKE ?", "%#{@query}%").page(params[:page]).per(3)
        @attractions = Attraction.where("name LIKE ? OR description LIKE ?", 
                                       "%#{@query}%", "%#{@query}%").page(params[:page]).per(3)
      end
    end
  end
end