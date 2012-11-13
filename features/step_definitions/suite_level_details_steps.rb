Then /^the junit output contains the testsuite element$/ do
  step 'I parse the junit results file'
  @results.xpath("/testsuites").size.should == 1
end

Then /^the junit output reports one passing test$/ do
  step 'I parse the junit results file'
  @results.xpath("/testsuites/@errors").first.value.should == "0"
  @results.xpath("/testsuites/@failures").first.value.should == "0"
  @results.xpath("/testsuites/@skipped").first.value.should == "0"
  @results.xpath("/testsuites/@tests").first.value.should == "1"
end

Then /^the junit output reports one failing test$/ do
  step 'I parse the junit results file'
  @results.xpath("/testsuites/@errors").first.value.should == "0"
  @results.xpath("/testsuites/@failures").first.value.should == "1"
  @results.xpath("/testsuites/@skipped").first.value.should == "0"
  @results.xpath("/testsuites/@tests").first.value.should == "1"
end

Then /^the junit output reports one pending test$/ do
  step 'I parse the junit results file'
  @results.xpath("/testsuites/@errors").first.value.should == "0"
  @results.xpath("/testsuites/@failures").first.value.should == "0"
  @results.xpath("/testsuites/@skipped").first.value.should == "1"
  @results.xpath("/testsuites/@tests").first.value.should == "1"
end

Then /^the junit output testsuite element contains a duration$/ do
  step 'I parse the junit results file'
  @results.xpath("/testsuites/@time").first.value.should match /[.0-9]+/
end

Then /^the junit output testsuite element contains a timestamp$/ do
  step 'I parse the junit results file'
  @results.xpath("/testsuites/@timestamp").first.value.should match /\d{4}-\d{2}-\d{2}T\d+:\d+:\d+\+\d+:\d+/
end
