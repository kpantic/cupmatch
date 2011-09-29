class Cup < ActiveRecord::Base
  acts_as_audited
  has_many :matches
  has_many :cup_winners
  has_many :winners, :through => :cup_winners, :source => :team
  has_attached_file :image, :styles => {:medium => "200x200", :thumb => "100x100"}
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/png", "image/jpeg"], :message => "Only .jpg and .png images are accepted"
  has_many :stadia, :through => :matches

  validates_presence_of :name, :country
  validates_uniqueness_of :name

  FREQUENCY_OPTIONS = ["Yearly","Every 2 years","Every 4 years"]

  def self.filter(argument_hash)
    result = Cup.where("")
    result = result.where("name like ?","%"+argument_hash[:name]+"%") unless argument_hash[:name].blank?
    result = result.where("country = ?",argument_hash[:country]) unless argument_hash[:country].blank?
    result = result.where("year_started = ?",argument_hash[:year_started]) unless argument_hash[:year].blank?

    return result
  end

end
