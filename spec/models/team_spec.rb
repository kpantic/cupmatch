require 'spec_helper'

describe Team do
  fixtures :teams
  [:name,:country].each do |attr|
    it "should not be valid without #{attr}" do
      subject.save.should be_false
      subject.errors[attr].should_not be_nil
    end
  end

  it 'should only accept .png and .jpg' do
    f = Factory(:team)
    f.image = File.new(Rails.root + 'spec/fixtures/images/barcelona.gif')
    f.should_not be_valid
    f.errors[:image_content_type].should_not be_nil
    f.image = File.new(Rails.root + 'spec/fixtures/images/barcelona.jpg')
    f.should be_valid
  end

  it 'should have an unique name in a specific country' do
    subject.name = "F.C. Barcelona"
    subject.country = "Spain"
    subject.should_not be_valid
    subject.errors[:name].should_not be_nil
    subject.country = "England"
    subject.should be_valid
  end

  it 'should filter by name' do
    result = Team.filter({:name => "Barcelona"})
    result.include?(teams(:fcbarcelona)).should be_true
    result.count.should == 1
  end

  it 'should filter by country' do
    result = Team.filter({:country => "Spain"})
    result.include?teams(:fcbarcelona).should be_true
    result.include?teams(:realmadrid).should be_true
    result.count.should == 2
  end

  it 'should filter by name and country' do
    result = Team.filter({:name => "F.C.", :country => "England"})
    result.include?teams(:arsenal).should be_true
    result.count.should == 1
  end
end
