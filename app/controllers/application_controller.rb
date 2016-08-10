class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound, with: :respond_with_404

  private

  def respond_with_404
    render(file: 'public/404', layout: false, status: :not_found)
  end
end
