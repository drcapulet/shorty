Given /I have created a new (.*) instance/ do |n|
  @instance = Shorty::Trim.new()
end

Given /I want to shorten (.*)/ do |n|
  @url = @instance.shorten(n)
end

Then /^I should see "([^\"]*)"$/ do |text|
  actual_output = File.read(@stdout)
  actual_output.should contain(text)
end

Then /the URL should look like "([^\"]*)"$/ do |text|
  @url.should contain(text)
end


