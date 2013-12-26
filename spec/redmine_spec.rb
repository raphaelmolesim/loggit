require 'spec_helper'

describe Redmine do
  
  it "should post a time entry to redmine" do
    pending 'this is a integrated test that you can run against a real environment'
    redmine = Redmine.instance
    time_entry = TimeEntry.new(
      project_id: 101,
      spent_on: Date.today, 
      hours: 2.0, 
      activity_id: Activities[:development],
      issue_id: nil, 
      comments: 'Reunião de alinhamento'
    )
    redmine.create_time_entry! time_entry
  end
  
end