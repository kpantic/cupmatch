class Team < ActiveRecord::Base
  acts_as_audited
  has_many :away_matches, :class_name => "Match", :foreign_key => "away_team_id"
  has_many :home_matches, :class_name => "Match", :foreign_key => "home_team_id"
  has_many :cup_winners
  has_many :cups, :through => :cup_winners

  has_attached_file :image, :styles => {:medium => "200x200", :thumb => "100x100"}
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/png", "image/jpeg"], :message => "Only .jpg and .png images are accepted"

  validates_presence_of :name, :country
  validates_uniqueness_of :name, :scope => [:country], :case_sensitive => false

  def self.filter(argument_hash)
    result = Team.where("")
    result = result.where("name like ?","%"+argument_hash[:name]+"%") unless argument_hash[:name].blank?
    result = result.where("country = ?",argument_hash[:country]) unless argument_hash[:country].blank?

    return result
  end
end
