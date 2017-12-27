# frozen_string_literal: true
require 'rails_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  def test_show
    get page_url(:about)

    assert_response(:success)
  end

  def test_show_non_existing_page
    get page_url(:foo)

    assert_response(:not_found)
  end
end
