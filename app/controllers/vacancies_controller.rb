class VacanciesController < ApplicationController
  before_action :store_token, except: [:index, :new, :create]

  def index; end

  def new; end

  def create
    if vacancy.save
      VacancyMailer.creation_notice(vacancy).deliver
      flash[:success] = t('vacancies.create.success')
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    respond_with_404 unless authorize!(:read, vacancy)
  end

  def edit
    respond_with_404 unless authorize!(:edit, vacancy)
  end

  def update
    respond_with_404 unless authorize!(:update, vacancy)

    if vacancy.update(parameters)
      flash[:success] = t('vacancies.update.success')
      redirect_to vacancy_url(vacancy)
    else
      render :edit
    end
  end

  def destroy
    respond_with_404 unless authorize!(:destroy, vacancy)

    vacancy.destroy and flash[:success] = t('vacancies.destroy.success')
    redirect_to root_url
  end

  def approve
    respond_with_404 unless authorize!(:approve, vacancy)

    vacancy.approve! and flash[:success] = t('vacancies.approve.success')
    VacancyMailer.approval_notice(vacancy).deliver
    redirect_to vacancy_url(vacancy)
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
