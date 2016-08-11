# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'A new vacancy page' do
  subject { page }

  before { visit new_vacancy_path }

  it 'displays title of the page' do
    expect(subject).to have_content(I18n.t('vacancies.new.title'))
  end
end
