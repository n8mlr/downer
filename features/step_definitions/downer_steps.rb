# Mock objec for simulating outpu
class Output
  def messages
    @messages ||= []
  end

  def puts(message)
    messages << message
  end
end

def output
  @output ||= Output.new
end

# Create temporary file with urls
def fixture_directory
  File.expand_path('../../../spec/fixtures', __FILE__)
end

Given /^I have not started application$/ do
end

When /^I start a new application without arguments$/ do
  app = Downer::Application.new(output)
  app.run!
end

Then /^I should see "([^"]*)"$/ do |message|
  output.messages.should include(message)
end



When /^I start a new application with valid arguments$/ do
  app = Downer::Application.new(output)
  app.run!(fixture_directory + '/some_images.txt', '/tmp')
end