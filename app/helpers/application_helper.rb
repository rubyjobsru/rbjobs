module ApplicationHelper
  def google_analytics_id
    ENV['GOOGLE_ANALYTICS_ID']
  end

  def intercom_id
    ENV['INTERCOM_ID']
  end
end
