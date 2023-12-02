require 'rake/testtask'
require './app'
require 'net/http'

namespace :solve do

  task :all do
    runner = Aoc::Runner.new
    (1..25).each { |i| runner.call(i) }
  end

  (1..25).each do |i|
    desc "Run day #{i}"
    task i.to_s.to_sym do
      Aoc::Runner.new.call(i)
    end
  end
end

namespace :scaffold do
  (1..25).each do |i|
    task i.to_s.to_sym do
      puts "🎁 Generate code for day #{i}..."

      number = i.to_s.rjust(2, '0')
      marker = '{DAY_NUMBER}'

      ruby_file = File.join(APP_ROOT, 'lib', 'days', "#{number}.rb")
      # raise '⛔ Stopping: Already exists' if File.exists?(ruby_file)

      File.write(ruby_file, File.read(File.join(APP_ROOT, 'template', 'day')).sub(marker, number))
      File.write(
        File.join(APP_ROOT, 'test', "#{number}_test.rb"),
        File.read(File.join(APP_ROOT, 'template', 'test')).gsub(marker, number)
      )
      File.write(File.join(APP_ROOT, 'examples', "#{number}.txt"), '')

    end
  end
end

namespace :download do

  def download_input(number)
    session_path = File.join(APP_ROOT, '.session')

    unless File.exist?(session_path)
      raise 'Copy your session cookie from a logged-in browser and save it to a file at `.session`!'
    end

    puts "⬇️ Download day #{number} input"

    response = Net::HTTP.get_response(
      URI("https://adventofcode.com/2023/day/#{number}/input"),
      { 'Cookie' => "session=#{File.read(session_path)}" }
    )

    if response.code == '200'
      response.body
    else
      puts "💥 Download failed - #{response.message}"
    end
  end

  (1..25).each do |i|
    task i.to_s.to_sym do
      number = i.to_s.rjust(2, '0')
      File.write(File.join(APP_ROOT, 'inputs', "#{number}.txt"), download_input(i))
    end
  end
end

Rake::TestTask.new do |t|
  t.pattern = 'test/*_test.rb'
end
