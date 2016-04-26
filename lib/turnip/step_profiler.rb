require 'turnip/step_profiler/version'
require 'turnip/rspec'

module Turnip
  module StepProfiler
    class StepExecute
      attr_reader :file, :time

      def initialize(file: '', time: 0)
        @file = file
        @time = time
      end
    end

    class CalledStep
      attr_reader :step

      def initialize(step)
        @step = step
        @called = []
      end

      def <<(step_execute)
        @called << step_execute
      end

      def average_time
        total_time / called_count
      end

      def total_time
        @called.inject(0.0) {|t, s| t + s.time }
      end

      def called_count
        @called.size
      end
    end

    class Profiler
      attr_reader :steps

      def initialize
        @steps = Hash.new {|h, k| h[k] = CalledStep.new(k) }
      end

      def show_slow_steps(count = 10)
        puts
        puts
        puts "Top #{count} slow steps:"

        each_steps_order_by_slow(count) do |step|
          puts "  #{step.step}"
          puts "    #{'%3.6f' % step.average_time} seconds average (#{'%3.3f' % step.total_time} seconds / #{step.called_count} call)"
        end

        puts
      end

      private

      def each_steps_order_by_slow(count)
        ordered_steps = @steps.sort_by {|_, step| step.average_time * -1 }

        ordered_steps[0..count].each do |_, step|
          yield(step)
        end
      end
    end

    module Define
      def step(step)
        s = Time.now
        super
        e = Time.now
        desc = step.class == String ? step : step.description

        if (step_profiler = Thread.current[:step_profiler])
          step_profiler.steps[desc] << StepExecute.new(file: Thread.current['current_file'], time: e - s)
        end
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
    Thread.current[:step_profiler] = Turnip::StepProfiler::Profiler.new
  end

  config.after(:suite) do
    step_profiler = Thread.current[:step_profiler]
    step_profiler.show_slow_steps if step_profiler
  end
end
