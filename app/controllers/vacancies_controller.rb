class VacanciesController < ApplicationController
  before_action :store_token, except: [:index, :new, :create]

  def index; end

  def new; end

  def create
    if vacancy.save
      VacancyMailer.creation_notice(vacancy).deliver
      flash[:success] = t('vacancies.create.success')
      redirect_to(root_url, status: :created) and return
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    unless authorize!(:read, vacancy)
      respond_with_404 and return
    end
  end

  def edit
    unless authorize!(:edit, vacancy)
      respond_with_404 and return
    end
  end

  def update
    unless authorize!(:update, vacancy)
      respond_with_404 and return
    end

    if vacancy.update(parameters)
      flash[:success] = t('vacancies.update.success')
      redirect_to(vacancy_url(vacancy), status: :no_content) and return
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    unless authorize!(:destroy, vacancy)
      respond_with_404 and return
    end

    vacancy.destroy and flash[:success] = t('vacancies.destroy.success')
    redirect_to(root_url, status: :no_content) and return
  end

  def approve
    unless authorize!(:approve, vacancy)
      respond_with_404 and return
    end

    vacancy.approve! and flash[:success] = t('vacancies.approve.success')
    VacancyMailer.approval_notice(vacancy).deliver
    redirect_to(vacancy_url(vacancy), status: :no_content) and return
  end

  private

  def parameters
    return {} if params[:vacancy].blank?

    params.require(:vacancy).permit(
      :title,
      :description,
      :location,
      :company,
      :url,
      :name,
      :email,
      :phone,
      :expire_at
    )
  end

  def vacancies
    @vacancies ||= Vacancy.available.page(params[:page]).per(6)
  end
  helper_method :vacancies

  def vacancy
    @vacancy ||= if params[:id]
                   Vacancy.find(params[:id])
                 else
                   Vacancy.new(parameters)
                 end
  end
  helper_method :vacancy

  def authorize!(action, vacancy)
    case action
    when :read
      return vacancy.approved? || admin?(vacancy)
    when :edit, :update
      return (vacancy.approved? && owner?(vacancy)) || admin?(vacancy)
    when :destroy, :approve
      return admin?(vacancy)
    else
      raise StandartError
    end
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
