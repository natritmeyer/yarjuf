Then /^the junit output file contains two testsuite elements named 'suite one' and 'suite two'$/ do
  step 'I parse the junit results file'
  expect(@results.xpath("/testsuites/testsuite").size).to eq 2
  expect(@results.xpath("/testsuites/testsuite/@name").map(&:text).sort).to match_array ["suite one", "suite two"]
end

Then /^the junit output file has one test against each suite$/ do
  step 'I parse the junit results file'
  expect(@results.xpath("/testsuites/testsuite/@tests").map(&:text)).to match_array ["1", "1"]
end

Then /^the junit output file has the correct test counts against each suite$/ do
  step 'I parse the junit results file'
  #suite one
  expect(@results.at_xpath("/testsuites/testsuite[@name='suite one']/@tests").value).to eq "4"
  expect(@results.at_xpath("/testsuites/testsuite[@name='suite one']/@failures").value).to eq "2"
  expect(@results.at_xpath("/testsuites/testsuite[@name='suite one']/@skipped").value).to eq "1"

  #suite two
  expect(@results.at_xpath("/testsuites/testsuite[@name='suite two']/@tests").value).to eq "6"
  expect(@results.at_xpath("/testsuites/testsuite[@name='suite two']/@failures").value).to eq "1"
  expect(@results.at_xpath("/testsuites/testsuite[@name='suite two']/@skipped").value).to eq "2"
end

