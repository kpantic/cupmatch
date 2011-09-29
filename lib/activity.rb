class Activity
  attr_accessor :user_email, :model, :model_type, :activity
  def initialize(hash)
    :user_email = hash[:user_email]
    :model = hash[:model]
    :model_type = hash[:model_type]
    :activity = hash[:activity]
  end

  def recent_activity
    audits = Audit.send(:with_exclusive_scope) { Audit.order('created_at desc').limit(10) }
    activity = []
    audits.each do |audit|
      activity << Activity.new({:user_email => audit.user.nil?? "Anonymous" : audit.user.email, :model => audit.auditable, :model_type => audit.auditable_type, :activity => audit.action })
    end
    return activity
  end
end
