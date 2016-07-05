class DateTimeBuilder
  WDAY_ENG = %w(sunday monday tuesday tuesday friday saturday).freeze

  def last_week(time, wday)
    wday = WDAY_ENG[wday]
    t = time.strftime('%H:%M')
    Chronic.parse("last #{wday} #{t}")
  end

  def next_week(time, wday)
    wday = WDAY_ENG[wday]
    t = time.strftime('%H:%M')
    Chronic.parse("this #{wday} #{t}")
  end
end
