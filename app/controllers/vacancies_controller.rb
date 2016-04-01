class VacanciesController < ApplicationController
  before_filter :assign_vacancy, :except => [:index, :new, :create]
  before_filter :store_token, :except => [:index, :new, :create]

  respond_to :html
  respond_to :xml, :only => :index

  include Authentication

  def index
    @vacancies = Vacancy.available.page(params[:page]).per(6)
    respond_with(@vacancies)
  end

  def new
    respond_with(@vacancy = Vacancy.new)
  end

  def create
    @vacancy = Vacancy.new(parameters)

    if @vacancy.save
      VacancyMailer.creation_notice(@vacancy).deliver
      flash[:success] = t("vacancies.create.success")
    end

    respond_with(@vacancy, :location => @vacancy.persisted? ?  root_url : nil)
  end

  def show
    if authorize!(:read, @vacancy)
      respond_with(@vacancy)
    else
      render(:file => 'public/404', :layout => false, :status => :not_found)
    end
  end

  def edit
    if authorize!(:edit, @vacancy)
      respond_with(@vacancy)
    else
      render(:file => 'public/404', :layout => false, :status => :not_found)
    end
  end

  def update
    if authorize!(:update, @vacancy)
      @vacancy.update_attributes(parameters) and flash[:success] = t("vacancies.update.success")
      respond_with(@vacancy)
    else
      render(:file => 'public/404', :layout => false, :status => :not_found)
    end
  end

  def destroy
    if authorize!(:destroy, @vacancy)
      @vacancy.destroy and flash[:success] = t("vacancies.destroy.success")
      respond_with(@vacancy, :location => root_url)
    else
      render(:file => 'public/404', :layout => false, :status => :not_found)
    end
  end

  def approve
    if authorize!(:approve, @vacancy)
      @vacancy.approve! and flash[:success] = t("vacancies.approve.success")
      VacancyMailer.approval_notice(@vacancy).deliver
      respond_with(@vacancy)
    else
      render(:file => 'public/404', :layout => false, :status => :not_found)
    end
  end

  private

  def parameters
    params.require(:vacancy).permit(
      :title, :description, :location, :company, :url, :name, :email,
      :phone, :expire_at
    )
  end

  def assign_vacancy
    @vacancy = Vacancy.find_by_id!(params[:id])
  end

  def owner?(vacancy)
    tokens.include?(vacancy.owner_token)
  end
  helper_method :owner?

  def admin?(vacancy)
    tokens.include?(vacancy.admin_token)
  end
  helper_method :admin?

  def token
    params[:token]
  end

  def tokens
    session[:tokens] || []
  end

  def store_token
    session[:tokens] = tokens.push(token).uniq if token.present?
  end
end
