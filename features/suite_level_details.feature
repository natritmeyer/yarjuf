Feature: Suite Summary
  As a tester
  In order to make the summary detail visible in jenkins
  I want to output the suite summary level detail to the output

  Scenario: testsuites element present
    Given a file named "spec/suite_element_spec.rb" with:
      """
      describe "suite element" do
        it "should be present" do
          1.should == 1
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
          1.should == 1
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
          1.should == 2
        end
      end
      """
    When I run `rspec spec/one_failing_test_spec.rb -r ../../lib/yarjuf -f JUnit -o results.xml`
    Then the junit output reports one failing test

