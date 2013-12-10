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

  Scenario: Correct test result counts at individual suite level
     Given a file named "spec/suite_one_spec.rb" with:
      """
      describe "suite one" do
        it "should contain one passing test" do
          1.should == 1
        end

        it "should contain one of two failing tests" do
          1.should == 2
        end

        it "should contain two of two failing tests" do
          1.should == 2
        end

        it "should contain 1 pending test" do
          pending
        end
      end
      """
    And a file named "spec/suite_two_spec.rb" with:
      """
      describe "suite two" do
        it "should contain one of 3 passing tests" do
          1.should == 1
        end

        it "should contain two of 3 passing tests" do
          1.should == 1
        end

        it "should contain three of 3 passing tests" do
          1.should == 1
        end

        it "should contain one failing test" do
          1.should == 2
        end

        it "should contain one of two pending tests" do
          pending
        end

        it "should contain two of two pending tests" do
          pending
        end
      end
      """
    When I run `rspec spec/suite_one_spec.rb spec/suite_two_spec.rb -r ../../lib/yarjuf -f JUnit -o results.xml`
    Then the junit output file contains two testsuite elements named 'suite one' and 'suite two'
    And the junit output file has the correct test counts against each suite
    When I run `rspec spec/suite_timestamp_spec.rb -r ../../lib/yarjuf -f JUnit -o results.xml`
    Then the junit output testsuite element contains a timestamp of each suite
