require 'spec_helper'

describe Match do
  fixtures :cups, :stadia, :teams, :matches
  [:date,:cup,:stadium,:away_team,:home_team,:away_team_result,:home_team_result].each do |attr|
    it "should not be valid without #{attr}" do
      subject.save.should be_false
      subject.errors[attr].should_not be_nil
    end
  end

  [:away_team_result, :home_team_result].each do |attr|
    it "should have a numeric #{attr}" do
      m = Factory(:match)
      m[attr] = "asd"
      m.should_not be_valid
      m[attr] = 1
      m.should be_valid
    end
  end

  [:away_team_result, :home_team_result].each do |attr|
    it "should have a positive #{attr}" do
      m = Factory(:match)
      m[attr] = -1
      m.should_not be_valid
      m[attr] = 0
      m.should be_valid
    end
  end

  it 'should filter by cup_id' do
    result = Match.filter({:cup_id => cups(:ucl).id})
    result.include?matches(:bcnars).should be_true
    result.count.should == 1
  end

  it 'should filter by stadium_id' do
    result = Match.filter({:stadium_id => stadia(:bernabeu).id})
    result.include?matches(:rmabcn).should be_true
    result.include?matches(:bcnrma).should be_true
    result.count.should == 2
  end

  it 'should filter by home_team_id' do
    result = Match.filter({:home_team_id => teams(:fcbarcelona).id})
    result.include?matches(:bcnars).should be_true
    result.include?matches(:bcnrma).should be_true
    result.count.should == 2
  end

  it 'should filter by away_team_id' do
    result = Match.filter({:away_team_id => teams(:fcbarcelona).id})
    result.include?matches(:arsbcn).should be_true
    result.include?matches(:rmabcn).should be_true
    result.count.should == 2
  end

  it 'should filter from from_date to to_date' do
    result = Match.filter({:from_date => Date.strptime('2011-06-10'), :to_date => Date.strptime('2011-06-11')})
    result.include?matches(:arsbcn).should be_true
    result.include?matches(:bcnrma).should be_true
    result.count.should == 2
  end

  it 'should not filter if just to_date or from_date is given' do
    result = Match.filter({:from_date => Date.strptime('2011-06-10')})
    result.count.should == 4
    result = Match.filter({:to_date => Date.strptime('2011-06-10')})
    result.count.should == 4
  end

end
