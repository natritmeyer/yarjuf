Then /^the junit output contains the testsuite element$/ do
  step 'I parse the junit results file'
  expect(@results.xpath("/testsuites").size).to eq 1
end

Then /^the junit output reports one passing test$/ do
  step 'I parse the junit results file'
  expect(@results.at_xpath("/testsuites/@errors").value).to eq "0"
  expect(@results.at_xpath("/testsuites/@failures").value).to eq "0"
  expect(@results.at_xpath("/testsuites/@skipped").value).to eq "0"
  expect(@results.at_xpath("/testsuites/@tests").value).to eq "1"
end

Then /^the junit output reports one failing test$/ do
  step 'I parse the junit results file'
  expect(@results.at_xpath("/testsuites/@errors").value).to eq "0"
  expect(@results.at_xpath("/testsuites/@failures").value).to eq "1"
  expect(@results.at_xpath("/testsuites/@skipped").value).to eq "0"
  expect(@results.at_xpath("/testsuites/@tests").value).to eq "1"
end

Then /^the junit output reports one pending test$/ do
  step 'I parse the junit results file'
  expect(@results.at_xpath("/testsuites/@errors").value).to eq "0"
  expect(@results.at_xpath("/testsuites/@failures").value).to eq "0"
  expect(@results.at_xpath("/testsuites/@skipped").value).to eq "1"
  expect(@results.at_xpath("/testsuites/@tests").value).to eq "1"
end

Then /^the junit output testsuite element contains a duration$/ do
  step 'I parse the junit results file'
  expect(@results.at_xpath("/testsuites/@time").value).to match /[.0-9]+/
end

Then /^the junit output testsuite element contains a timestamp$/ do
  step 'I parse the junit results file'
  expect(@results.at_xpath("/testsuites/@timestamp").value).to match /\d{4}-\d{2}-\d{2}T\d+:\d+:\d+\+\d+:\d+/
end

