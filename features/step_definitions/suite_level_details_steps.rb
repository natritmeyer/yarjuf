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

