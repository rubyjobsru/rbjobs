require 'rails_helper'

RSpec.describe 'Edit vacancy page' do
  subject { page }

  context 'when vacancy is approved' do
    let(:vacancy) { create(:approved_vacancy) }

    it 'is not available for random visitor' do
      visit edit_vacancy_path(vacancy)
      expect(subject.status_code).to eql(404)
    end

    it 'is not available for visitor with wrong access token' do
      visit edit_vacancy_path(vacancy, token: 'foo')
      expect(subject.status_code).to eql(404)
    end

    it 'is available for author' do
      visit edit_vacancy_path(vacancy, token: vacancy.owner_token)
      expect(subject.status_code).to eql(200)
      expect(subject).to have_content(I18n.t('vacancies.edit.title'))
    end

    it 'is available for admin' do
      visit edit_vacancy_path(vacancy, token: vacancy.admin_token)
      expect(subject.status_code).to eql(200)
      expect(subject).to have_content(I18n.t('vacancies.edit.title'))
    end
  end

  context 'when vacancy is not approved yet' do
    let(:vacancy) { create(:disapproved_vacancy) }

    it 'is not available for random visitor' do
      visit edit_vacancy_path(vacancy)
      expect(subject.status_code).to eql(404)
    end

    it 'is not available for visitor with wrong access token' do
      visit edit_vacancy_path(vacancy, token: 'foo')
      expect(subject.status_code).to eql(404)
    end

    it 'is not available for author' do
      visit edit_vacancy_path(vacancy, token: vacancy.owner_token)
      expect(subject.status_code).to eql(404)
    end

    it 'is available for admin' do
      visit edit_vacancy_path(vacancy, token: vacancy.admin_token)
      expect(subject.status_code).to eql(200)
      expect(subject).to have_content(I18n.t('vacancies.edit.title'))
    end
  end
end
