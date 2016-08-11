# frozen_string_literal: true
# Customize the error messages HTML
# There will be no div element enclosing the input element
ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  html_tag
end
