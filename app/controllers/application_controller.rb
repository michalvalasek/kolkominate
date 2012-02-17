class ApplicationController < ActionController::Base
  protect_from_forgery

	def after_sign_in_path_for(resource)
		stored_location_for(resource) || expenses_path
	end

	def after_sign_out_path_for(resource)
		root_path
	end

  unless Rails.configuration.consider_all_requests_local
    rescue_from Exception, :with => :render_error
    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
    rescue_from ActionController::RoutingError, :with => :render_not_found
    rescue_from ActionController::UnknownController, :with => :render_not_found
    rescue_from ActionController::UnknownAction, :with => :render_not_found
  end

  private

    def render_not_found(exception)
      #log_error(exception)
      render :template => "/error/404.html.erb", :status => 404
    end

    def render_error(exception)
      #log_error(exception)
      render :template => "/error/500.html.erb", :status => 500
    end    
end
