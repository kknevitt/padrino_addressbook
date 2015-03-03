require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Person Model" do

  before do
    @person = Person.create!(:first_name=>"Kristian", :last_name=>"Knevitt", :email=>"kristian.knevitt@gmail.com", :phone=>"07827813794", :twitter=>"knev123")
  end

  it "should create a new Person in the db" do
    assert_equal 1, Person.count
  end

  it "should save the correct information" do
    assert_equal "Kristian", Person.first.first_name
  end

end
