class DateTimeBuilder
  WDAY_ENG = %w(sunday monday tuesday wednesday thursday friday saturday).freeze

  def previous_wday(time, wday)
    time = time.strftime('%H:%M')
    week_of_day = WDAY_ENG[wday]

    case
    when !reporting_day?(wday)
      Chronic.parse("last #{week_of_day} #{time}")
    when across_report_time?(time)
      Chronic.parse("today #{time}")
    else
      Chronic.parse("last #{week_of_day} #{time}") # chronic's specification
    end
  end

  def next_wday(time, wday)
    time = time.strftime('%H:%M')
    week_of_day = WDAY_ENG[wday]

    case
    when !reporting_day?(wday)
      Chronic.parse("this #{week_of_day} #{time}")
    when across_report_time?(time)
      Chronic.parse("this #{week_of_day} #{time}") # chronic's specification
    else
      Chronic.parse("today #{time}")
    end
  end

  private

  def reporting_day?(wday)
    Time.zone.now.wday == wday
  end

  def across_report_time?(time)
    report_time = Chronic.parse("today #{time}")
    report_time < Time.zone.now
  end
end
