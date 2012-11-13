Feature: Individual suites
  As a tester
  In order to see relevant tests grouped together in suites
  I want to be able to differentiate between different `describe` blocks

  Scenario: Differentiating between 2 suites
    Given a file named "spec/suite_one_spec.rb" with:
      """
      describe "suite one" do
        it "should contain one test" do
          1.should == 1
        end
      end
      """
    And a file named "spec/suite_two_spec.rb" with:
      """
      describe "suite two" do
        it "should also contain one test" do
          1.should == 1
        end
      end
      """
    When I run `rspec spec/suite_one_spec.rb spec/suite_two_spec.rb -r ../../lib/yarjuf -f JUnit -o results.xml`
    Then the junit output file contains two testsuite elements named 'suite one' and 'suite two'
    And the junit output file has one test against each suite

