When /^I parse the junit results file$/ do
  results_file = 'tmp/aruba/results.xml'
  File.should exist results_file
  @results = Nokogiri::XML File.open(results_file)
end

