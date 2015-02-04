require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Person Model" do
  it 'can construct a new instance' do
    @person = Person.new
    refute_nil @person
  end
end
