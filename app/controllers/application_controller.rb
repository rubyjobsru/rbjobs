# frozen_string_literal: true
class ApplicationController < ActionController::Base
  before_action :set_visitor_store

  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound, with: :respond_with_404

  def current_visitor
    @current_visitor ||= Visitor.find_or_create
  end
  helper_method :current_visitor

  private

  def respond_with_404
    render(file: 'public/404', layout: false, status: :not_found)
  end

  def set_visitor_store
    Visitor.store = cookies.permanent.encrypted
  end
end
