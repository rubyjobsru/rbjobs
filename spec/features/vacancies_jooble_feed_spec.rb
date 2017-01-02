# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Vacancies Jooble feed' do
  let!(:approved_vacancy) { persist_vacancy(build(:approved_vacancy)) }
  let!(:disapproved_vacancy) { persist_vacancy(build(:disapproved_vacancy)) }
  let!(:archived_vacancy) { persist_vacancy(build(:archived_vacancy)) }

  subject { page }

  before { visit feeds_jooble_path }

  it 'displays vacancies in XML format' do
    expect(subject.body).to start_with('<?xml')
  end

  it 'displays approved vacancy' do
    expect(subject.body).to include(approved_vacancy.title)
  end

  it 'does not display disapproved vacancy' do
    expect(subject.body).not_to include(disapproved_vacancy.title)
  end

  it 'does not display archived/expired vacancy' do
    expect(subject.body).not_to include(archived_vacancy.title)
  end
end
