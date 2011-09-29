class CupWinner < ActiveRecord::Base
  acts_as_audited
  belongs_to :cup
  belongs_to :team
  validates_presence_of :year, :cup, :team
end
