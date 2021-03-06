class RoutesController < ApplicationController
  include ChangesSearchable
  helper_method :sort_column, :sort_direction

  def index
    set_routes

    set_changes

    if params[:sort]
      sort_routes(@routes)
    end
  end

  private

    def set_routes
      @routes = Route.where(nil)
      filtering_params(params).each do |key, value|
        @routes = @routes.public_send(key, value) if value.present?
      end
    end

    def sort_routes(routes)
      if params[:sort] == 'duration'
        @routes = routes.sort_by{|route| route.duration}
        @routes = @routes.reverse if sort_direction == 'desc'
      else
        @routes = routes.order(sort_column + ' ' + sort_direction)
      end
    end

   def sort_column
      if params[:sort] == 'duration'
        "duration"
      else
        Route.column_names.include?(params[:sort]) ? params[:sort] : "depart"
      end
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

    def filtering_params(params)
      params.slice(:start_point, :end_point, :depart, :city)
    end
end
