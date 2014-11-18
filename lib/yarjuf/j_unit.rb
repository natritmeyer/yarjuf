# An RSpec formatter for generating results in JUnit format
class JUnit
  RSpec::Core::Formatters.register self, :example_passed, :example_failed, :example_pending, :dump_summary

  def initialize(output)
    @output             = output
    @test_suite_results = {}
    @builder            = Builder::XmlMarkup.new :indent => 2
  end

  def example_passed(example_notification)
    add_to_test_suite_results example_notification
  end

  def example_failed(example_notification)
    add_to_test_suite_results example_notification
  end

  def example_pending(example_notification)
    add_to_test_suite_results example_notification
  end

  def dump_summary(summary)
    build_results(summary.duration, summary.examples.size, summary.failed_examples.size, summary.pending_examples.size)
    @output.puts @builder.target!
  end

  protected

  def add_to_test_suite_results(example_notification)
    suite_name                      = JUnit.root_group_name_for example_notification
    @test_suite_results[suite_name] = [] unless @test_suite_results.keys.include? suite_name
    @test_suite_results[suite_name] << example_notification.example
  end

  def failure_details_for(example)
    exception           = example.exception
    formatted_backtrace = RSpec::Core::BacktraceFormatter.new.format_backtrace exception.backtrace
    exception.nil? ? '' : "#{exception.message}\n#{formatted_backtrace}"
  end

  # utility methods

  def self.count_in_suite_of_type(suite, test_case_result_type)
    suite.select { |example| example.metadata[:execution_result].status == test_case_result_type }.size
  end

  def self.root_group_name_for(example_notification)
    example_notification.example.metadata[:example_group][:description]
  end

  # methods to build the xml for test suites and individual tests

  def build_results(duration, example_count, failure_count, pending_count)
    @builder.instruct! :xml, :version => "1.0", :encoding => "UTF-8"
    @builder.testsuites(
      :errors    => 0,
      :failures  => failure_count,
      :skipped   => pending_count,
      :tests     => example_count,
      :time      => duration,
      :timestamp => Time.now.iso8601) do
      build_all_suites
    end
  end

  def build_all_suites
    @test_suite_results.each do |suite_name, tests|
      build_test_suite(suite_name, tests)
    end
  end

  def build_test_suite(suite_name, tests)
    failure_count = JUnit.count_in_suite_of_type(tests, :failed)
    skipped_count = JUnit.count_in_suite_of_type(tests, :pending)

    @builder.testsuite(
      :name     => suite_name,
      :tests    => tests.size,
      :errors   => 0,
      :failures => failure_count,
      :skipped  => skipped_count) do
      @builder.properties
      build_all_tests tests
    end
  end

  def build_all_tests(tests)
    tests.each do |test|
      build_test test
    end
  end

  def build_test(test)
    test_name      = test.metadata[:full_description]
    execution_time = test.metadata[:execution_result].run_time
    test_status    = test.metadata[:execution_result].status

    @builder.testcase(:name => test_name, :time => execution_time) do
      case test_status
        when :pending
          @builder.skipped
        when :failed
          build_failed_test test
      end
    end
  end

  def build_failed_test(test)
    failure_message = "failed #{test.metadata[:full_description]}"

    @builder.failure(:message => failure_message, :type => 'failed') do
      @builder.cdata!(filter_unsupported(failure_details_for(test)))
    end
  end

  def filter_unsupported(str)
    str.gsub!(/[^[:print:]\t\n]/, '') if str

    str
  end
end
