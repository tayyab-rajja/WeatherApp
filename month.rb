# frozen_string_literal: true

module Month
  def month_data
    path = Dir["#{File.expand_path(ARGV[3])}/*"].each.map { |f| File.basename(f) }
    find_path_month(path)
  end

  def find_path_month(path)
    year = ARGV[1].to_s
    file_path = ARGV[3].to_s
    selected_files = path.select { |f| f.include? "#{year}_#{ARGV[2]}" }
    open_selected_month(selected_files, file_path)
  end

  def open_selected_month(selected_files, file_path)
    line = []
    selected_files.each do |filename|
      r = File.open("#{file_path}#{filename}")
      r.drop(1).each { |l| line.push l }
    end
    split_array_month(line)
  end

  def split_array_month(line)
    i = 0
    while i < line.length
      line[i] = line[i].split(',')
      i += 1
    end
    find_avg_high_temp(line)
  end

  def find_avg_high_temp(line)
    avg_high_temp = 0
    avg_high_temp_count = 0
    line.each do |outer|
      unless outer[1].nil?
        avg_high_temp += outer[1].to_i
        avg_high_temp_count += 1
      end
    end
    avg_high_temp = (avg_high_temp / avg_high_temp_count)
    find_avg_low_temp(avg_high_temp, line)
  end

  def find_avg_low_temp(avg_high_temp, line)
    avg_low_temp = 0
    avg_low_temp_count = 0
    line.each do |outer|
      unless outer[3].nil?
        avg_low_temp += outer[3].to_i
        avg_low_temp_count += 1
      end
    end
    avg_low_temp = (avg_low_temp / avg_low_temp_count)
    find_avg_humidity(avg_high_temp, avg_low_temp, line)
  end

  def find_avg_humidity(avg_high_temp, avg_low_temp, line)
    avg_humid = 0
    avg_humid_count = 0
    line.each do |outer|
      unless outer[8].nil?
        avg_humid += outer[8].to_i
        avg_humid_count += 1
      end
    end
    avg_humid = (avg_humid / avg_humid_count)
    display_month(avg_high_temp, avg_low_temp, avg_humid)
  end

  def display_month(avg_high_temp, avg_low_temp, avg_humid)
    puts "Highest Average:  #{avg_high_temp}C"
    puts "Lowest Average:   #{avg_low_temp}C"
    puts "Average Humidity: #{avg_humid}%"
  end
end
