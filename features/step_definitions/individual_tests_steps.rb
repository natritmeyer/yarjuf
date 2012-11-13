Then /^the junit output file contains a test result with a simple name$/ do
  step 'I parse the junit results file'
  @results.at_xpath("/testsuites/testsuite[@name='suite one']/testcase/@name").value.should == "suite one simple name"
end

