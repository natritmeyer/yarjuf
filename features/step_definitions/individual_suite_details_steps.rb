Then /^the junit output file contains two testsuite elements named 'suite one' and 'suite two'$/ do
  step 'I parse the junit results file'
  @results.xpath("/testsuites/testsuite").size.should == 2
  @results.xpath("/testsuites/testsuite/@name").map(&:text).should == ["suite one", "suite two"]
end

Then /^the junit output file has one test against each suite$/ do
  step 'I parse the junit results file'
  @results.xpath("/testsuites/testsuite/@tests").map(&:text).should == ["1", "1"]
end

