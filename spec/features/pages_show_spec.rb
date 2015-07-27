require 'rails_helper'

RSpec.describe 'A static page' do
  subject { page }

  context 'when requested page exists' do
    let(:static_page) { Page.find_by_id(Page.ids.first) }

    before { visit page_path(static_page.id) }

    it 'successfully responds with the requested page' do
      expect(subject).to have_content(static_page.title)
    end
  end

  context 'when requested page does not exist' do
    before { visit page_path('foo') }

    it 'responds with HTTP 404 Not Found' do
      expect(subject.status_code).to eql(404)
    end

    it 'responds with 404 page' do
      expect(subject).to have_content('Такой страницы не существует на этом сайте')
    end
  end
end
