Then /^the junit output file contains two testsuite elements named 'suite one' and 'suite two'$/ do
  step 'I parse the junit results file'
  @results.xpath("/testsuites/testsuite").size.should == 2
  @results.xpath("/testsuites/testsuite/@name").map(&:text).should == ["suite one", "suite two"]
end

