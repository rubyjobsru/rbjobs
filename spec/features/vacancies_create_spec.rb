# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Post a new vacancy' do
  let!(:attributes) { attributes_for(:vacancy) }

  subject { page }

  context 'when vacancy form was filled out correctly' do
    before do
      visit new_vacancy_path
      fill_in 'vacancy_title', with: attributes[:title]
      fill_in 'vacancy_description', with: attributes[:description]
      fill_in 'vacancy_location', with: attributes[:location]
      fill_in 'vacancy_email', with: attributes[:email]
      choose 'vacancy_expires_in_one_week'
      click_on I18n.t('vacancies.form.create')
    end

    it 'redirects to root page' do
      expect(subject).to have_content('You are being redirected')
    end

    it 'displays a confirmation message for author' do
      visit root_path
      expect(subject).to have_content(I18n.t('vacancies.create.success'))
    end

    it 'does not display the posted vacancy yet on the root page' do
      visit root_path
      expect(subject).not_to have_content(attributes[:title])
    end
  end

  context 'when vacancy form was not filled out correctly' do
    before do
      visit new_vacancy_path
      fill_in 'vacancy_title', with: attributes[:title]
      # other required fields are left blank
      click_on I18n.t('vacancies.form.create')
    end

    it 'does not redirect to root page' do
      expect(subject).not_to have_current_path(root_path)
    end

    it 'does not display a confirmation message for author' do
      expect(subject).not_to have_content(I18n.t('vacancies.create.success'))
    end
  end
end
