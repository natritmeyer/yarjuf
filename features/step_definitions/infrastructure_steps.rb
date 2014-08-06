When /^I parse the junit results file$/ do
  results_file = 'tmp/aruba/results.xml'
  expect(File).to exist results_file
  @results ||= Nokogiri::XML File.open(results_file)
end

