#! /usr/bin/env ruby
require_relative '../lib/loop.rb'
scraper = Scraper.new('https://www.simplyhired.com/search?q=junior+web+developer&l=&job=qv7hkzh7TcZD8BEHuKv9Eguc_mML6R1OujyCtaMQug7JaEnfmK10kA')
scraper.start

def prompt
  puts "Would you like to continue to see more vacancies? \n \n"
  puts "For continue \n Type 'y' or press 'Enter' \n \n"
  puts "To stop and quit \n Type 'n' or 'q' \n \n"
  loop do
    input = gets.chomp.downcase
    if ['y', ''].include?(input)
      @page += 1
      break
    elsif %w[n q].include?(input)
      exit
    else
      puts "Oops! Invalid character! \n\n"
      puts "For continue \n Type 'y' or press 'Enter' \n \n"
      puts "To stop and quit \n Type 'n' or 'q' \n \n"
      input
    end
    input
  end
end

def info
  @scraper = Scraper.new('https://www.simplyhired.com/search?q=junior+web+developer&l=&job=qv7hkzh7TcZD8BEHuKv9Eguc_mML6R1OujyCtaMQug7JaEnfmK10kA')
  @scraper.start
  @total = @scraper.instance_variable_get(:@total)
  @last_page = @scraper.instance_variable_get(:@last_page)
  puts "Overall #{@total}  jobs in #{@last_page} pages \n\n Let's see results! \n\n"
  sleep(1.5)
  @page = 1
  @collect = Loop.new(@total, @page)
end

def results
  info
  while @page <= @total
    puts "Page Number: #{@page} \n\n"
    sleep 0.5
    @collect.scrapper
    list = @collect.instance_variable_get(:@list)
    i = 0
    while i < list.count
      puts "Found jobs \n\n"
      puts "Position: #{list[i][:position]} \n Company: #{list[i][:company]}"
      puts "Location: #{list[i][:location]} \n Salary: #{list[i][:salary]}"
      puts "Job link: https://www.simplyhired.com#{list[i][:url]}"
      puts ''
      sleep(0.1)
      i += 1
    end
    prompt
    sleep(0.5)
  end
end
results
