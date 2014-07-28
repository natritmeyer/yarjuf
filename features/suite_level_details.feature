Feature: Suite Summary
  As a tester
  In order to make the summary detail visible in jenkins
  I want to output the suite summary level detail to the output

  Scenario: testsuites element present
    Given a file named "spec/suite_element_spec.rb" with:
      """
      describe "suite element" do
        it "should be present" do
          expect(1).to eq 1
        end
      end
      """
    When I run `rspec spec/suite_element_spec.rb -r ../../lib/yarjuf -f JUnit -o results.xml`
    Then the junit output contains the testsuite element

  Scenario: One passing test
    Given a file named "spec/one_passing_test_spec.rb" with:
      """
      describe "suite level details for 1 passing test" do
        it "should pass" do
          expect(1).to eq 1
        end
      end
      """
    When I run `rspec spec/one_passing_test_spec.rb -r ../../lib/yarjuf -f JUnit -o results.xml`
    Then the junit output reports one passing test

  Scenario: One failing test
    Given a file named "spec/one_failing_test_spec.rb" with:
      """
      describe "suite level details for 1 failing test" do
        it "should fail" do
          expect(1).to eq 2
        end
      end
      """
    When I run `rspec spec/one_failing_test_spec.rb -r ../../lib/yarjuf -f JUnit -o results.xml`
    Then the junit output reports one failing test

  Scenario: One pending test
    Given a file named "spec/one_pending_test_spec.rb" with:
      """
      describe "suite level details for 1 pending test" do
        it "should be pending" do
          pending
          fail
        end
      end
      """
    When I run `rspec spec/one_pending_test_spec.rb -r ../../lib/yarjuf -f JUnit -o results.xml`
    Then the junit output reports one pending test

  Scenario: Test suite duration
    Given a file named "spec/suite_duration_spec.rb" with:
      """
      describe "suite element duration" do
        it "should contain a duration" do
          expect(1).to eq 1
        end
      end
      """
    When I run `rspec spec/suite_duration_spec.rb -r ../../lib/yarjuf -f JUnit -o results.xml`
    Then the junit output testsuite element contains a duration

  Scenario: Test suite time stamp
    Given a file named "spec/suite_timestamp_spec.rb" with:
      """
      describe "suite element timestamp" do
        it "should contain a timestamp" do
          expect(1).to eq 1
        end
      end
      """
    When I run `rspec spec/suite_timestamp_spec.rb -r ../../lib/yarjuf -f JUnit -o results.xml`
    Then the junit output testsuite element contains a timestamp

