require 'time'
require 'builder'
require 'rspec/core/formatters/base_formatter'

class JUnit < RSpec::Core::Formatters::BaseFormatter
  def initialize(output)
    super output
  end

  def example_passed(example)

  end

  def example_failed(example)

  end

  def example_pending(example)

  end

  def dump_summary(duration, example_count, failure_count, pending_count)

  end
end

