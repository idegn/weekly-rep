require 'test_helper'

class DateTimeBuilderTest < ActiveSupport::TestCase
  NOW = Time.new(2016, 7, 6, 10, 00) # wednesday ( wday is 3 )

  test "#last_week should return previous wday when - 1 sec" do
    Timecop.freeze(NOW - 1.second)
    t = DateTimeBuilder.new.previous_wday(NOW, 3)
    assert_equal Time.new(2016, 6, 29, 10, 0), t
  end

  test "#last_week should return previous wday when + 1 sec" do
    Timecop.freeze(NOW + 1.second)
    t = DateTimeBuilder.new.previous_wday(NOW, 3)
    assert_equal t, Time.new(2016, 7, 6, 10, 0)
  end

  test "#last_week should return previous wday when + 1 day" do
    Timecop.freeze(NOW - 1.day)
    t = DateTimeBuilder.new.previous_wday(NOW, 3)
    assert_equal Time.new(2016, 6, 29, 10, 0), t
  end

  test "#last_week should return previous wday when - 1day" do
    Timecop.freeze(NOW + 1.day)
    t = DateTimeBuilder.new.previous_wday(NOW, 3)
    assert_equal t, Time.new(2016, 7, 6, 10, 0)
  end

  test "#next_wday should return next wday when - 1 sec" do
    Timecop.freeze(NOW - 1.second)
    t = DateTimeBuilder.new.next_wday(NOW, 3)
    assert_equal t, Time.new(2016, 7, 6, 10, 0)
  end

  test "#next_wday should return next wday when + 1 sec" do
    Timecop.freeze(NOW + 1.second)
    t = DateTimeBuilder.new.next_wday(NOW, 3)
    assert_equal t, Time.new(2016, 7, 13, 10, 0)
  end

  test "#next_wday should return next wday when - 1 day" do
    Timecop.freeze(NOW - 1.day)
    t = DateTimeBuilder.new.next_wday(NOW, 3)
    assert_equal t, Time.new(2016, 7, 6, 10, 0)
  end

  test "#next_wday should return next wday when + 1 day" do
    Timecop.freeze(NOW + 1.day)
    t = DateTimeBuilder.new.next_wday(NOW, 3)
    assert_equal t, Time.new(2016, 7, 13, 10, 0)
  end
end
