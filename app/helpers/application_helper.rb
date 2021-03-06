# frozen_string_literal: true
module ApplicationHelper
  def google_analytics_id
    ENV['GOOGLE_ANALYTICS_ID']
  end

  def intercom_id
    ENV['INTERCOM_ID']
  end

  def current_url
    @current_url ||= request.original_url
  end
end
