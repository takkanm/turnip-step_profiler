require "turnip/step_profiler/version"
require 'turnip/rspec'

module Turnip
  module StepProfiler
    class Logger
      attr_reader :steps

      def initialize
        @steps = Hash.new {|h, k| h[k] = [] }
      end
    end

    module Define
      def step(step)
        s = Time.now
        super
        e = Time.now
        desc = step.class == String ? step : step.description

        step_profiler = Thread.current[:step_profiler]
        step_profiler.steps[desc] << {file: Thread.current['current_file'], time: e - s}
      end

      def run_step(feature_file, step)
        Thread.current['current_file'] = feature_file
        super
      end
    end
  end
end

Turnip::RSpec::Execute.prepend Turnip::StepProfiler::Define

::RSpec.configure do |config|
  config.before(:suite) do
    Thread.current[:step_profiler] = Turnip::StepProfiler::Logger.new
  end

  config.after(:suite) do
    step_profiler = Thread.current[:step_profiler]

    puts
    puts "profiled steps:"

    step_profiler.steps.sort_by {|key, steps|
      (steps.inject(0.0) {|t, s| t + s[:time] }) / steps.size
    }.reverse_each {|key, steps|
      total = steps.inject(0.0) {|t, s| t + s[:time] }
      avg   = total / steps.size

      puts "  #{key}"
      puts "    #{"%3.6f" % avg} seconds average (#{"%3.3f" % total} seconds / #{steps.size} call)"
    }

    puts
  end
end
