class Project
  
  class << self
    
    def find_by_id id
      projects.select { |project| project["id"] == id }.first
    end
    
    def find_by_name name
      projects.select { |project| project["name"] == name }.first
    end
    
    private
    
      def projects
        redmine = Redmine.instance
        redmine.load_projects
      end
    
  end
  
end