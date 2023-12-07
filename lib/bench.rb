module Aoc
  class Bench
    require 'benchmark'

    def call(number, part, iterations = 20)
      day = get_day_class(number)
      return unless day

      input_path = File.join(APP_ROOT, 'inputs', "#{number.to_s.rjust(2, '0')}.txt")
      raise 'Input does not exist' unless File.exist?(input_path)

      input_data = File.read(input_path).rstrip

      Benchmark.bm do |bench|
        bench.report do
          iterations.times do
            day.send("part#{part}", input_data)
          end
        end
      end
    end

    private

    def get_day_class(number)
      Object.const_get("Day#{number.to_s.rjust(2, '0')}").new
    rescue NameError
      # puts "Day #{number} not implemented"
    end
  end
end
