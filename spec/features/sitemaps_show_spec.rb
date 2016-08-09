require 'rails_helper'

RSpec.describe 'A sitemap page' do
  subject { page }

  it 'responds with HTTP 200 OK' do
    visit sitemap_path(format: :xml)
    expect(subject.status_code).to eql(200)
  end
end
