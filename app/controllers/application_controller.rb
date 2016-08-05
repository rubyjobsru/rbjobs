class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def respond_with_404
    render(file: 'public/404', layout: false, status: :not_found)
    return false
  end
end
