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

Then /^the junit output file contains a failing test$/ do
  step 'I parse the junit results file'
  @results.at_xpath("/testsuites/testsuite/testcase/failure").should_not be_nil
  @results.at_xpath("/testsuites/testsuite/testcase/failure/@message").value.should == "failed suite one should be failing"
  @results.at_xpath("/testsuites/testsuite/testcase/failure/@type").value.should == "failed"
  @results.at_xpath("/testsuites/testsuite/testcase/failure").text.should match /expected.*2.*got.*1.*using.*==.*spec\/failing_test_spec\.rb:3/m
end

