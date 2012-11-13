Then /^the junit output file contains two testsuite elements named 'suite one' and 'suite two'$/ do
  step 'I parse the junit results file'
  @results.xpath("/testsuites/testsuite").size.should == 2
  @results.xpath("/testsuites/testsuite/@name").map(&:text).should == ["suite one", "suite two"]
end

Then /^the junit output file has one test against each suite$/ do
  step 'I parse the junit results file'
  @results.xpath("/testsuites/testsuite/@tests").map(&:text).should == ["1", "1"]
end

Then /^the junit output file has the correct test counts against each suite$/ do
  step 'I parse the junit results file'
  #suite one
  @results.at_xpath("/testsuites/testsuite[@name='suite one']/@tests").value.should == "4"
  @results.at_xpath("/testsuites/testsuite[@name='suite one']/@failures").value.should == "2"
  @results.at_xpath("/testsuites/testsuite[@name='suite one']/@skipped").value.should == "1"

  #suite two
  @results.at_xpath("/testsuites/testsuite[@name='suite two']/@tests").value.should == "6"
  @results.at_xpath("/testsuites/testsuite[@name='suite two']/@failures").value.should == "1"
  @results.at_xpath("/testsuites/testsuite[@name='suite two']/@skipped").value.should == "2"
end

