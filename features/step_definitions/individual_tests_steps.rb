Then /^the junit output file contains a test result with a simple name$/ do
  step 'I parse the junit results file'
  expect(@results.at_xpath("/testsuites/testsuite[@name='suite one']/testcase/@name").value).to eq "suite one simple name"
end

Then /^the junit output file has a nicely rendered nested test name$/ do
  step 'I parse the junit results file'
  expect(@results.at_xpath("/testsuites/testsuite/testcase/@name").value).to eq "something that is really deep should still be displayed nicely"
end

Then /^the junit output file contains a test with a duration$/ do
  step 'I parse the junit results file'
  expect(@results.at_xpath("/testsuites/testsuite/testcase/@time").value).to match /[.0-9]+/
end

Then /^the junit output file contains a pending test$/ do
  step 'I parse the junit results file'
  expect(@results.at_xpath("/testsuites/testsuite/testcase/skipped")).to_not be_nil
end

Then /^the junit output file contains a failing test$/ do
  step 'I parse the junit results file'
  expect(@results.at_xpath("/testsuites/testsuite/testcase/failure")).to_not be_nil
  expect(@results.at_xpath("/testsuites/testsuite/testcase/failure/@message").value).to eq "failed suite one should be failing"
  expect(@results.at_xpath("/testsuites/testsuite/testcase/failure/@type").value).to eq "failed"
  expect(@results.at_xpath("/testsuites/testsuite/testcase/failure").text).to match /expected.*2.*got.*1.*using.*==.*spec\/failing_test_spec\.rb:3/m
end

