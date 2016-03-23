json.array!(@weekly_reports) do |weekly_report|
  json.extract! weekly_report, :id, :user_id, :content, :reporting_time
  json.url weekly_report_url(weekly_report, format: :json)
end
