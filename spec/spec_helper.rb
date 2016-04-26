require 'turnip/rspec'
require 'turnip/step_profiler'

step 'I wait :n seconds' do |n|
  sleep n.to_i
end

step 'there is a monster' do
  # nop
end

step 'it should die' do
  sleep 2
end

