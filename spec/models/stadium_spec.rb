require 'spec_helper'

describe Stadium do
  fixtures :stadia
  [:name,:country].each do |attr|
    it "should not be valid without #{attr}" do
      subject.save.should be_false
      subject.errors[attr].should_not be_nil
    end
  end

  it 'should only accept .png and .jpg' do
    c = Factory(:stadium)
    c.image = File.new(Rails.root + 'spec/fixtures/images/campnou.gif')
    c.should_not be_valid
    c.errors[:image_content_type].should_not be_nil
    c.image = File.new(Rails.root + 'spec/fixtures/images/campnou.jpg')
    c.should be_valid
  end

  it 'should have an unique name in a specific country' do
    subject.name = "Camp Nou Stadium"
    subject.country = "Spain"
    subject.should_not be_valid
    subject.errors[:name].should_not be_nil
    subject.country = "England"
    subject.should be_valid
  end

  it 'should have a numeric capacity' do
    s = Factory(:stadium)
    s.capacity = "asd"
    s.should_not be_valid
    s.capacity = 10000
    s.should be_valid
  end

  it 'should have a positive capacity' do
    s = Factory(:stadium)
    s.capacity = -1
    s.should_not be_valid
    s.capacity = 10000
    s.should be_valid
  end

  it 'should filter by name' do
    result = Stadium.filter({:name => "Camp"})
    result.include?(stadia(:campnou)).should be_true
    result.count.should == 1
  end

  it 'should filter by country' do
    result = Stadium.filter({:country => "Spain"})
    result.include?stadia(:campnou).should be_true
    result.include?stadia(:bernabeu).should be_true
    result.count.should == 2
  end

  it 'should filter by name and country' do
    result = Stadium.filter({:name => "Stadium", :country => "England"})
    result.include?stadia(:oldtrafford).should be_true
    result.count.should == 1
  end
end
