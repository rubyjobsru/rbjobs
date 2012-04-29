# Customize the error messages HTML
# There will be no div element enclosing the input element
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag
end