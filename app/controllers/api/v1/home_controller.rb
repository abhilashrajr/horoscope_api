module Api
  module V1
    class HomeController < ApplicationController
      def index
        p "!!!!!!!!!!!!!!!!!"
        
        h = Horoscope::Horo.new(
          :datetime => Time.utc(params[:date_time].to_i), 
          :zone => params[:zone].to_i,
          :lat => params[:lat].to_i, :lon => params[:lon].to_i)
        data = h.compute
        render json: {result: true, data: data}
      end
    end
  end
end