# frozen_string_literal: true
# rubocop:disable Metrics/ClassLength
class VacanciesController < ApplicationController
  before_action :store_token, except: [:index, :new, :create]
  before_action :ensure_authorized, except: [:index, :new, :create]

  def index; end

  def new; end

  def create
    create_vacancy!

    if vacancy.persisted?
      redirect_to(root_url, status: :see_other,
                            flash: { success: t('vacancies.create.success') })
      return
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    update_vacancy!

    if vacancy.errors.empty?
      redirect_to(vacancy_url(vacancy), status: :see_other,
                                        flash: {
                                          success: t('vacancies.update.success')
                                        })
      return
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    destroy_vacancy!

    flash[:success] = t('vacancies.destroy.success') if vacancy.destroyed?
    redirect_to(root_url, status: :see_other)
  end

  def approve
    approve_vacancy!

    flash[:success] = t('vacancies.approve.success') if vacancy.approved?
    redirect_to(vacancy_url(vacancy), status: :see_other)
  end

  private

  def create_vacancy!
    @vacancy = Vacancies::Creator.run(vacancy)
  end

  def update_vacancy!
    @vacancy.attributes = parameters
    @vacancy = Vacancies::Updater.run(vacancy)
  end

  def destroy_vacancy!
    @vacancy = Vacancies::Destroyer.run(vacancy)
  end

  def approve_vacancy!
    @vacancy = Vacancies::Approver.run(vacancy)
  end

  def parameters
    return {} if params[:vacancy].blank?

    params.require(:vacancy).permit(
      :title,
      :description,
      :location,
      :remote_position,
      :salary_min,
      :salary_max,
      :salary_currency,
      :salary_unit,
      :employment_type,
      :company,
      :url,
      :name,
      :email,
      :phone,
      :expire_at
    )
  end

  def vacancies
    @vacancies ||= Vacancy.onlin.recent.page(params[:page]).per(6)
  end
  helper_method :vacancies

  def vacancy
    @vacancy ||= if params[:id]
                   Vacancies::Default.new(Vacancy.find(params[:id]))
                 else
                   Vacancy.new(parameters)
                 end
  end
  helper_method :vacancy

  def feed_vacancies
    @feed_vacancies ||= Vacancy.online.recent
  end
  helper_method :feed_vacancies

  def authorized?(action, vacancy)
    case action
    when :show
      return vacancy.approved? || admin?(vacancy)
    when :edit, :update
      return (vacancy.approved? && owner?(vacancy)) || admin?(vacancy)
    when :destroy, :approve
      return admin?(vacancy)
    else
      raise StandardError
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

  def ensure_authorized
    respond_with_404 unless authorized?(action_name.to_sym, vacancy)
  end

  def store_token
    session[:tokens] = tokens.push(token).uniq if token.present?
  end
end
