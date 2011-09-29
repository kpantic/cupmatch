require 'spec_helper'

describe CupWinner do
  [:year, :cup, :team].each do |attr|
    it "should not be valid without #{attr}" do
      subject.save.should be_false
      subject.errors[attr].should_not be_nil
    end
  end
end
