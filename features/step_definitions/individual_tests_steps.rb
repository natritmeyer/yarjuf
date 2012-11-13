Then /^the junit output file contains a test result with a simple name$/ do
  step 'I parse the junit results file'
  @results.at_xpath("/testsuites/testsuite[@name='suite one']/testcase/@name").value.should == "suite one simple name"
end

Then /^the junit output file has a nicely rendered nested test name$/ do
  step 'I parse the junit results file'
  @results.at_xpath("/testsuites/testsuite/testcase/@name").value.should == "something that is really deep should still be displayed nicely"
end

Then /^the junit output file contains a test with a duration$/ do
  step 'I parse the junit results file'
  @results.at_xpath("/testsuites/testsuite/testcase/@time").value.should match /[.0-9]+/
end

Then /^the junit output file contains a pending test$/ do
  step 'I parse the junit results file'
  @results.at_xpath("/testsuites/testsuite/testcase/skipped").should_not be_nil
end

