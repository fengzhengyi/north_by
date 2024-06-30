# frozen_string_literal: true

class ScheduleDay
  include ActiveModel::Model
  attr_accessor :day, :concerts, :hidden

  def initialize(day, concerts, hidden: false)
    @day = day
    @concerts = concerts
    @hidden = hidden
  end

  def day_string
    day.by_example('2024-06-29')
  end

  def day_of?(string)
    return false unless string

    day == Date.parse(string)
  end

  def hide!
    @hidden = true
  end

  def toggle!
    @hidden = !@hidden
  end
end
