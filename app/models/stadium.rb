class Stadium < ActiveRecord::Base
  acts_as_audited
  has_many :matches
  has_many :cups, :through => :matches

  has_attached_file :image, :styles => {:medium => "200x200", :thumb => "100x100"}
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/png", "image/jpeg"], :message => "Only .jpg and .png images are accepted"

  validates_presence_of :name, :country
  validates_uniqueness_of :name, :scope => [:country], :case_sensitive => false
  validates_numericality_of :capacity, :greater_than => 0, :allow_blank => true

  def self.filter(argument_hash)
    result = Stadium.where("")
    result = result.where("name like ?","%"+argument_hash[:name]+"%") unless argument_hash[:name].blank?
    result = result.where("country = ?",argument_hash[:country]) unless argument_hash[:country].blank?

    return result
  end

end
