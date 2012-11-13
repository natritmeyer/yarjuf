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
    builder = Builder::XmlMarkup.new :indent => 2
    builder.instruct! :xml, :version => "1.0", :encoding => "UTF-8"
    builder.testsuites :errors => 0, :failures => failure_count, :skipped => pending_count, :tests => example_count, :time => duration, :timestamp => Time.now.iso8601
    output.puts builder.target!
  end
end

