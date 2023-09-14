# frozen_string_literal: true

require_relative 'year'
require_relative 'day'
require_relative 'month'
require_relative 'day_bonus'

class Project
  include Year
  include Month
  include Day
  include DayBonus

  def main
    case ARGV[0]
    when '-e'
      year_data
    when '-a'
      month_data
    when '-c'
      day_data
    when '-b'
      day_data_bonus
    else
      puts 'Wrong Input'
    end
  end
end

obj = Project.new
obj.main
