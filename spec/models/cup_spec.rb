require 'spec_helper'

describe Cup do
  fixtures :cups
  [:name,:country].each do |attr|
    it "should not be valid without #{attr}" do
      subject.save.should be_false
      subject.errors[attr].should_not be_nil
    end
  end

  it 'should only accept .png and .jpg' do
    c = Factory(:cup)
    c.image = File.new(Rails.root + 'spec/fixtures/images/ucl.gif')
    c.should_not be_valid
    c.errors[:image_content_type].should_not be_nil
    c.image = File.new(Rails.root + 'spec/fixtures/images/ucl.jpg')
    c.should be_valid
  end

  it 'should have an unique name' do
    subject.name = "UEFA Champions League"
    subject.country = "England"
    subject.should_not be_valid
    subject.errors[:name].should_not be_nil
  end

  it 'should filter by name' do
    result = Cup.filter({:name => "Champions"})
    result.include?(cups(:ucl)).should be_true
    result.count.should == 1
  end

  it 'should filter by country' do
    result = Cup.filter({:country => "Spain"})
    result.include?cups(:ucl).should be_true
    result.include?cups(:laliga).should be_true
    result.count.should == 2
  end

  it 'should filter by name and country' do
    result = Cup.filter({:name => "League", :country => "England"})
    result.include?cups(:premier).should be_true
    result.count.should == 1
  end
end
