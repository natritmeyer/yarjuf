Then /^the junit output contains the testsuite element$/ do
  step 'I parse the junit results file'
  @results.xpath("/testsuites").size.should == 1
end

Then /^the junit output reports one passing test$/ do
  step 'I parse the junit results file'
  @results.at_xpath("/testsuites/@errors").value.should == "0"
  @results.at_xpath("/testsuites/@failures").value.should == "0"
  @results.at_xpath("/testsuites/@skipped").value.should == "0"
  @results.at_xpath("/testsuites/@tests").value.should == "1"
end

Then /^the junit output reports one failing test$/ do
  step 'I parse the junit results file'
  @results.at_xpath("/testsuites/@errors").value.should == "0"
  @results.at_xpath("/testsuites/@failures").value.should == "1"
  @results.at_xpath("/testsuites/@skipped").value.should == "0"
  @results.at_xpath("/testsuites/@tests").value.should == "1"
end

Then /^the junit output reports one pending test$/ do
  step 'I parse the junit results file'
  @results.at_xpath("/testsuites/@errors").value.should == "0"
  @results.at_xpath("/testsuites/@failures").value.should == "0"
  @results.at_xpath("/testsuites/@skipped").value.should == "1"
  @results.at_xpath("/testsuites/@tests").value.should == "1"
end

Then /^the junit output testsuite element contains a duration$/ do
  step 'I parse the junit results file'
  @results.at_xpath("/testsuites/@time").value.should match /[.0-9]+/
end

Then /^the junit output testsuite element contains a timestamp$/ do
  step 'I parse the junit results file'
  @results.at_xpath("/testsuites/@timestamp").value.should match /\d{4}-\d{2}-\d{2}T\d+:\d+:\d+\+\d+:\d+/
end

