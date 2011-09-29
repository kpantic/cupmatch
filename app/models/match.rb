class Match < ActiveRecord::Base
  acts_as_audited
  belongs_to :stadium
  belongs_to :cup
  belongs_to :away_team, :class_name => "Team", :foreign_key => "away_team_id"
  belongs_to :home_team, :class_name => "Team", :foreign_key => "home_team_id"
  validates_presence_of :date,:cup,:stadium,:away_team,:home_team,:away_team_result,:home_team_result
  validates_numericality_of :away_team_result, :home_team_result, :greater_than_or_equal_to => 0, :allow_blank => true

  def self.filter(argument_hash)
    filter_hash = {}
    filter_hash[:away_team_id] = argument_hash[:away_team_id] unless argument_hash[:away_team_id].blank?
    filter_hash[:home_team_id] = argument_hash[:home_team_id] unless argument_hash[:home_team_id].blank?
    filter_hash[:stadium_id] = argument_hash[:stadium_id] unless argument_hash[:stadium_id].blank?
    filter_hash[:cup_id] = argument_hash[:cup_id] unless argument_hash[:cup_id].blank?
    filter_hash[:date] = argument_hash[:from_date]..argument_hash[:to_date] unless argument_hash[:from_date].blank? || argument_hash[:to_date].blank? || !(argument_hash[:from_date].is_a?Date) || !(argument_hash[:to_date].is_a?Date)
    
    return Match.where(filter_hash)
  end
end
