Feature: Individual Tests
  As a tester
  In order to be able to see details of individual tests
  I want to write out test results

  Scenario: Simple test name
    Given a file named "spec/simple_test_name_spec.rb" with:
      """
      describe "suite one" do
        it "simple name" do
          expect(1).to eq 1
        end
      end
      """
    When I run `rspec spec/simple_test_name_spec.rb -r ../../lib/yarjuf -f JUnit -o results.xml`
    Then the junit output file contains a test result with a simple name

  Scenario: Nested tests
    Given a file named "spec/nested_spec.rb" with:
      """
      describe "something" do
        context "that" do
          context "is" do
            context "really" do
              context "deep" do
                it "should still be displayed nicely" do
                  expect(1).to eq 1
                end
              end
            end
          end
        end
      end
      """
    When I run `rspec spec/nested_spec.rb -r ../../lib/yarjuf -f JUnit -o results.xml`
    Then the junit output file has a nicely rendered nested test name

  Scenario: Test duration
    Given a file named "spec/test_duration_spec.rb" with:
      """
      describe "suite one" do
        it "should do something" do
          expect(1).to eq 1
        end
      end
      """
    When I run `rspec spec/test_duration_spec.rb -r ../../lib/yarjuf -f JUnit -o results.xml`
    Then the junit output file contains a test with a duration

  Scenario: Pending test
    Given a file named "spec/pending_test_spec.rb" with:
      """
      describe "suite one" do
        it "should be pending" do
          pending
          fail
        end
      end
      """
    When I run `rspec spec/pending_test_spec.rb -r ../../lib/yarjuf -f JUnit -o results.xml`
    Then the junit output file contains a pending test

  Scenario: Failing test
    Given a file named "spec/failing_test_spec.rb" with:
      """
      describe "suite one" do
        it "should be failing" do
          expect(1).to eq 2
        end
      end
      """
    When I run `rspec spec/failing_test_spec.rb -r ../../lib/yarjuf -f JUnit -o results.xml`
    Then the junit output file contains a failing test

