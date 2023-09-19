# frozen_string_literal: true

require 'date'
module Year
  def year_data
    path = Dir["#{File.expand_path(ARGV[2])}/*"].each.map { |f| File.basename(f) }
    find_path_year(path)
  end

  def find_path_year(path)
    year = ARGV[1].to_s
    file_path = ARGV[2].to_s
    selected_files = path.select { |f| f.include? year.to_s }
    open_selected_year(selected_files, file_path)
  end

  def open_selected_year(selected_files, file_path)
    line = []
    selected_files.each do |filename|
      r = File.open("#{file_path}#{filename}")
      r.drop(1).each { |l| line.push l }
    end
    split_array_year(line)
  end

  def split_array_year(line)
    i = 0
    while  i < line.length
      line[i] = line[i].split(',')
      i += 1
    end
    find_max(line)
  end

  def find_max(line)
    max = 0
    max_date = ''
    line.each do |outer|
      if outer[1].to_i > max
        max = outer[1].to_i
        max_date = outer[0]
      end
    end
    find_min(max, max_date, line)
  end

  def find_min(max, max_date, line)
    min = line[1][3].to_i
    min_date = ''
    line.each do |outer|
      if outer[3].to_i < min
        min = outer[3].to_i
        min_date = outer[0]
      end
    end
    find_humidity(max, max_date, min, min_date, line)
  end

  def find_humidity(max, max_date, min, min_date, line)
    max_humid = 0
    humid_date = ''
    line.each do |outer|
      if outer[7].to_i > max_humid
        max_humid = outer[7].to_i
        humid_date = outer[0]
      end
    end
    display_year(max, max_date, min, min_date)
    display_humidity(max_humid, humid_date)
  end

  def display_humidity(max_humid, humid_date)
    puts "Humid : #{max_humid}C on #{Date::MONTHNAMES[humid_date.split('-')[1].to_i]} #{humid_date.split('-')[2].to_i}"
  end

  def display_year(max, max_date, min, min_date)
    puts "Highest: #{max}C on #{Date::MONTHNAMES[max_date.split('-')[1].to_i]} #{max_date.split('-')[2].to_i}"
    puts "Lowest: #{min}C on #{Date::MONTHNAMES[min_date.split('-')[1].to_i]} #{min_date.split('-')[2].to_i}"
  end
end
