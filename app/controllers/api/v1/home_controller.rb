module Api
  module V1
    class HomeController < ApplicationController

      def index
        result = { result: false }
        if params[:date].present? && params[:time].present?
          begin
            horoscope = find_horoscope(horoscope_params)
            data = horoscope.compute
            result[:result] = !horoscope.errors.present?
            result[:data] = data
          rescue Exception => e
            result[:data] = "Please check the input format"
          end
        else
          result[:data] = "date and time fields are mandatory"
        end
        render json: result
      end



      private

      def find_horoscope(options={})
        date = options[:date].split('/')
        time = options[:time].split(':')
        h = Horoscope::Horo.new(
          :datetime => Time.utc(date[0].to_i, date[1].to_i, date[2].to_i, time[0].to_i, time[1].to_i),
          :zone     => options[:zone].to_i,
          :lat      => options[:lat].to_i, :lon => options[:lon].to_i)
      end

      def horoscope_params
        params.permit(:date, :time, :zone, :lat, :lon)
      end

    end
  end
end