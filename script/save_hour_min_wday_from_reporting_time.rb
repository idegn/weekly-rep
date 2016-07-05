# Save `hour`, `min` and `wday` from `reporting_time`
# Now, `hour`, `min`, and `wday` are not saved in Groups table.

class ReportingTimeSpliter
  def call
    Group.find_each do |g|
      g.update_attributes(
        report_wday: g.reporting_time.wday,
        report_time: "#{g.reporting_time.hour}:#{g.reporting_time.min}"
      )
    end
  end
end

ReportingTimeSpliter.new.call
