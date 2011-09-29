require 'ostruct'

module ApplicationHelper

end

class Activity
  attr_accessor :user_email, :model_name, :model_type, :activity

  def initialize(hash)
    @user_email = hash[:user_email]
    @model = hash[:model]
    @model_type = hash[:model_type]
    @activity = hash[:activity]
  end

  def self.recent_activity
    @recent_activity = [];
    audits = Audit.send(:with_exclusive_scope) { Audit.order('created_at desc').limit(10) }
    audits.each do |audit|
      @recent_activity << Activity.new(:user_email => audit.user.blank?? "Anonymous":audit.user.email, :model => audit.auditable.blank?? "Unknown": audit.auditable, :model_type => audit.auditable_type, :activity => audit.action)
    end

    return @recent_activity
  end
end
