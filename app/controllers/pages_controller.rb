class PagesController < ApplicationController
  before_filter :assign_page

  respond_to :html

  def show
    if @page.present?
      respond_with(@page)
    else
      render(:file => "public/404", :layout => false, :status => :not_found)
    end
  end

  private

  def assign_page
    @page = Page.find_by_id(params[:id])
  end
end
