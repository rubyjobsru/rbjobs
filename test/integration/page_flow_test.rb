# frozen_string_literal: true
require 'rails_helper'

class PageFlowTest < ActionDispatch::IntegrationTest
  def test_open_a_page
    page = Page.find(:about)

    get root_url
    assert_response(:success)

    get page_url(page.id)
    assert_response(:success)
    assert_select('h1', page.title)
  end
end
