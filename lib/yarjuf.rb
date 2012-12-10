require 'time'
require 'builder'
require 'rspec/core/formatters/base_formatter'

class JUnit < RSpec::Core::Formatters::BaseFormatter
  def initialize(output)
    super output
    @test_suite_results = {}
  end

  def example_passed(example)
    add_to_test_suite_results(example)
  end

  def example_failed(example)
    add_to_test_suite_results(example)
  end

  def example_pending(example)
    add_to_test_suite_results(example)
  end

  def dump_summary(duration, example_count, failure_count, pending_count)
    builder = Builder::XmlMarkup.new :indent => 2
    build_results builder, duration, example_count, failure_count, pending_count
    output.puts builder.target!
  end

  protected

  def add_to_test_suite_results(example)
    suite_name = root_group_name_for(example)
    @test_suite_results[suite_name] = [] unless @test_suite_results.keys.include?(suite_name)
    @test_suite_results[suite_name] << example
  end

  #dealing with test names and their hierarchies

  def root_group_name_for(example)
    group_hierarchy = []
    current_example_group = example.metadata[:example_group]
    until current_example_group.nil? do
      group_hierarchy.unshift current_example_group
      current_example_group = current_example_group[:example_group]
    end
    group_hierarchy.first[:description]
  end

  #logic around stack traces for failed tests

  def failure_details_for(example)
    exception = example.metadata[:execution_result][:exception]
    exception.nil? ? "" : "#{exception.message}\n#{format_backtrace(exception.backtrace, example).join("\n")}"
  end

  #calculate various counts used at the test suite level

  def fail_count_for_suite(suite)
    count_of_test_case_result_type_for_suite suite, "failed"
  end

  def skipped_count_for_suite(suite)
    count_of_test_case_result_type_for_suite suite, "pending"
  end

  def count_of_test_case_result_type_for_suite(suite, test_case_result_type)
    suite.select {|example| example.metadata[:execution_result][:status] == test_case_result_type}.size
  end

  #methods to build the xml for test suites and individual tests

  def build_results(builder, duration, example_count, failure_count, pending_count)
    builder.instruct! :xml, :version => "1.0", :encoding => "UTF-8"
    builder.testsuites :errors => 0, :failures => failure_count, :skipped => pending_count, :tests => example_count, :time => duration, :timestamp => Time.now.iso8601 do
      @test_suite_results.each do |suite_name, tests|
        build_test_suite builder, suite_name, tests
      end
    end
  end

  def build_test_suite(builder, suite_name, tests)
    builder.testsuite :name => suite_name, :tests => tests.size, :errors => 0, :failures => fail_count_for_suite(tests), :skipped => skipped_count_for_suite(tests) do
      builder.properties
      tests.each do |test|
        build_test builder, test
      end
    end
  end

  def build_test(builder, test)
    builder.testcase :name => test.metadata[:full_description], :time => test.metadata[:execution_result][:run_time] do
      case test.metadata[:execution_result][:status]
      when "pending" then builder.skipped
      when "failed" then build_failed_test builder, test
      end
    end
  end

  def build_failed_test(builder, test)
    builder.failure :message => "failed #{test.metadata[:full_description]}", :type => "failed" do
      builder.cdata! failure_details_for test
    end
  end
end

