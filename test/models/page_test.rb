# frozen_string_literal: true
require 'rails_helper'

class PageTest < ActiveSupport::TestCase
  def test_class_method_find
    assert_not_nil(Page.find('about'), 'Returns the page when it exists')
    assert_nil(Page.find('foo'), 'Returns nil when the page does not exist')
  end

  def test_title
    page = Page.find('about')
    assert_not_empty(page.title)
  end

  def test_body
    page = Page.find('about')
    assert_not_empty(page.body)
  end
end
