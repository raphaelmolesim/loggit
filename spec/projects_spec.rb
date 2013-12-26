require 'spec_helper'

describe Project do

  let(:project) do
    {
      "created_on"=>"2013/07/03 03:49:49 +0000", 
      "identifier"=>"armazembrazil-0", 
      "updated_on"=>"2013/07/03 03:49:49 +0000", 
      "name"=>"Armazém Brasil", 
      "description"=>"", "id" => 78
    }
  end

  it "should find project by id" do
    instance = double "Redmine"
    instance.stub(:load_projects).and_return([project])
    Redmine.stub(:instance).and_return instance
    project = Project.find_by_id 78
    project["identifier"].should == "armazembrazil-0"
    project["name"].should == "Armazém Brasil"
    project["created_on"].should == "2013/07/03 03:49:49 +0000"
  end
  
  it "should find project by name" do
    instance = double "Redmine"
    instance.stub(:load_projects).and_return([project])
    Redmine.stub(:instance).and_return instance
    project = Project.find_by_name "Armazém Brasil"
    project["identifier"].should == "armazembrazil-0"
    project["id"].should == 78
    project["created_on"].should == "2013/07/03 03:49:49 +0000"
  end

end