# frozen_string_literal: true

require_relative 'colors'

module DayBonus
  def day_data_bonus
    path = Dir["#{File.expand_path(ARGV[3])}/*"].each.map { |f| File.basename(f) }
    find_path_bonus(path)
  end

  def find_path_bonus(path)
    year = ARGV[1].to_s
    file_path = ARGV[3].to_s
    selected_files = path.select { |f| f.include? "#{year}_#{ARGV[2]}" }
    open_selected_bonus(selected_files, file_path)
  end

  def open_selected_bonus(selected_files, file_path)
    line = []
    selected_files.each do |filename|
      r = File.open("#{file_path}#{filename}")
      r.drop(1).each { |l| line.push l }
    end
    split_array_bonus(line)
  end

  def split_array_bonus(line)
    i = 0
    while i < line.length
      line[i] = line[i].split(',')
      i += 1
    end
    graph_bar_bonus(line)
  end

  def graph_bar_bonus(line)
    i = 1
    line.each do |line_values|
      print i
      print_blue(line_values)
      print_red(line_values)
      puts " #{line_values[3]}C - #{line_values[1]}C"
      i += 1
    end
  end

  def print_blue(line_values)
    (0..line_values[3].to_i).each do
      print '+'.blue
    end
  end

  def print_red(line_values)
    (0..(line_values[1].to_i - line_values[3].to_i)).each do
      print '+'.red
    end
  end
end
