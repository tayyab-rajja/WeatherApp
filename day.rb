# frozen_string_literal: true

require_relative 'colors'

module Day
  def day_data
    path = Dir["#{File.expand_path(ARGV[3])}/*"].each.map { |f| File.basename(f) }
    find_path_day(path)
  end

  def find_path_day(path)
    year = ARGV[1].to_s
    file_path = ARGV[3].to_s
    selected_files = path.select { |f| f.include? "#{year}_#{ARGV[2]}" }
    open_selected_day(selected_files, file_path)
  end

  def open_selected_day(selected_files, file_path)
    line = []
    selected_files.each do |filename|
      r = File.open("#{file_path}#{filename}")
      r.drop(1).each { |l| line.push l }
    end
    split_array_day(line)
  end

  def split_array_day(line)
    i = 0
    while i < line.length
      line[i] = line[i].split(',')
      i += 1
    end
    graph_bar(line)
  end

  def graph_bar(line)
    i = 1
    line.each do |line_value|
      print i
      next if line_value[1].nil?

      high_temp(line_value)
      puts "#{line_value[1]}C"
      print i
      low_temp(line_value)
      i += 1
      puts "#{line_value[3]}C"
    end
  end

  def high_temp(line_value)
    (0..line_value[1].to_i).each do
      print '+'.red
    end
  end

  def low_temp(line_value)
    (0..line_value[3].to_i).each do
      print '+'.blue
    end
  end
end
