Then /^the junit output contains the testsuite element$/ do
  step 'I parse the junit results file'
  @results.xpath("/testsuites").size.should == 1
end

