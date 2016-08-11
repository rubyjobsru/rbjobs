require 'rails_helper'

RSpec.describe 'Vacancies index page' do
  let!(:approved_vacancy) { persist_vacancy(build(:approved_vacancy)) }
  let!(:disapproved_vacancy) { persist_vacancy(build(:disapproved_vacancy)) }
  let!(:archived_vacancy) { persist_vacancy(build(:archived_vacancy)) }

  subject { page }

  before { visit vacancies_path }

  it 'displays approved vacancy' do
    expect(subject).to have_content(approved_vacancy.title)
  end

  it 'does not display disapproved vacancy' do
    expect(subject).not_to have_content(disapproved_vacancy.title)
  end

  it 'does not display archived/expired vacancy' do
    expect(subject).not_to have_content(archived_vacancy.title)
  end
end
