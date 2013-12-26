require 'active_model'

class TimeEntry
  include ActiveModel::Model
  
  attr_accessor :project_id, :spent_on, :hours, :activity_id, :issue_id, :comments, :started_at, :ended_at
 
  validates_presence_of :project_id, :spent_on, :hours, :activity_id
  
  def to_h
    require 'json'
    { 
      "project_id" => project_id, 
      "spent_on" => spent_on,
      "hours" => hours, 
      "activity_id" => activity_id, 
      "issue_id" => issue_id
    }.inject({}) { |r, (k,v)| r[k] = v.to_json if v ; r  }.
      merge(full_description ? { "comments" => full_description } : {}) 
  end
  
  def project_name
    Project.find_by_id(project_id)["identifier"]
  end
  
  def full_description
    return comments if not (started_at and ended_at)
    
    "[#{"%02d" % started_at.hour}:#{"%02d" % started_at.min} - #{"%02d" % ended_at.hour}:#{"%02d" % ended_at.min}] #{comments}"
    end
  
end