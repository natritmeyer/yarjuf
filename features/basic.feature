Feature: Basic use of Yarjuf
  As a tester
  In order to be able to get junit formatted results from rspec
  I want to be able to use yarjuf

  Background:
    Given a file named "spec/basic_spec.rb" with:
      """
      describe "basic usage" do
        it "should work" do
          expect(true).to be true
        end
      end
      """

  Scenario: Requiring Yarjuf
    When I run `rspec spec/basic_spec.rb -r ../../lib/yarjuf -f JUnit`
    Then the exit status should be 0

  Scenario: Writing output to a file
    When I run `rspec spec/basic_spec.rb -r ../../lib/yarjuf -f JUnit -o results.xml`
    Then the exit status should be 0
    And a file named "results.xml" should exist

