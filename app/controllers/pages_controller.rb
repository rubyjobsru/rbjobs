# frozen_string_literal: true
class PagesController < ApplicationController
  def show
    respond_with_404 unless page.present?
  end

  private

  def page
    @page ||= Page.find(params[:id])
  end
  helper_method :page
end
