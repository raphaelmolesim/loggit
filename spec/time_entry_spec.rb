require 'spec_helper'

describe TimeEntry do
  
  context 'should validates presence of' do
    let(:time_entry) do
      time_entry = TimeEntry.new
      time_entry.valid? ; time_entry
    end
    
    it 'spent_on' do
      time_entry.errors[:spent_on].should include "can't be blank"
    end
    it 'hours' do
      time_entry.errors[:hours].should include "can't be blank"
    end
    it 'activity_id' do
      time_entry.errors[:activity_id].should include "can't be blank"
    end
    it 'project_id' do
      time_entry.errors[:project_id].should include "can't be blank"
    end
  end
  
  let(:time_entry) {
    TimeEntry.new(
      project_id: 101,
      spent_on: Date.today, 
      hours: 2.0, 
      activity_id: Activities[:development],
      issue_id: 10, 
      comments: 'Reunião de alinhamento'
    )
  }
  
  it "should be able to create an valid object" do
    time_entry.project_id.should == 101
    time_entry.spent_on.should  == Date.today
    time_entry.hours.should == 2.0
    time_entry.activity_id.should == 9
    time_entry.comments.should == 'Reunião de alinhamento'
    time_entry.should be_valid
  end
  
  context "should transform in a hash" do
    it "should transform all fields" do
      json_data = time_entry.to_h
      json_data["project_id"].should == "101"
      json_data["spent_on"].should  == "\"#{Date.today.strftime("%Y-%m-%d")}\""
      json_data["hours"].should == "2.0"
      json_data["activity_id"].should == "9"
      json_data["issue_id"].should == "10"
      json_data["comments"].should == 'Reunião de alinhamento'
    end
  
    it "should remove keys without values" do
      clone = time_entry.clone
      clone.issue_id = nil
      clone.comments = nil
      json_data = clone.to_h
      json_data["project_id"].should == "101"
      json_data["spent_on"].should  == "\"#{Date.today.strftime("%Y-%m-%d")}\""
      json_data["hours"].should == "2.0"
      json_data["activity_id"].should == "9"
      json_data.keys.include?("issue_id").should be_false
      json_data.keys.include?("comments").should be_false
    end
    
    it "should call the full description to set the comments" do
      clone = time_entry.clone
      base = Date.today.strftime("%Y-%m-%d").split("-")
      clone.started_at = Time.new( *(base + [10, 0, 0]) )
      clone.ended_at = Time.new( *(base + [12, 30, 0]) )
      json_data = clone.to_h
      json_data["comments"].should == '[10:00 - 12:30] Reunião de alinhamento'
    end
  end
  
  it "should lookup its own project name" do 
    time_entry.project_name.should == "diversos"
  end
  
  context "#full description" do
    it "should create a full description with 'started at' and 'ended at' heading the comments" do 
      base = Date.today.strftime("%Y-%m-%d").split("-")
      time_entry.started_at = Time.new( *(base + [10, 0, 0]) )
      time_entry.ended_at = Time.new( *(base + [12, 30, 0]) )
      time_entry.full_description.should == "[10:00 - 12:30] Reunião de alinhamento"
    end
  
    it "should create return the simple comments when both date are no set" do 
      time_entry.full_description.should == "Reunião de alinhamento"
    end
  end
end