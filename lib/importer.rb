require 'yaml'

class Importer
  
  def parse_csv csv_file
    time_entries = []
    require 'csv'
    CSV.foreach(csv_file, encoding: "ISO-8859-1:UTF-8") do |row|
      next if row[0] == "Start"
      
      day0 = row[0].split(" ").first.split("/").reverse.map(&:to_i)
      started_at = day0 + row[0].split(" ").last.split("h").map(&:to_i)
      day1 = row[1].split(" ").first.split("/").reverse.map(&:to_i)
      ended_at = day1 + row[1].split(" ").last.split("h").map(&:to_i)
      hours = row[2].split(":").map(&:to_i)
      if (hours.size > 2)
        hours = "#{ "%.2f" % (hours[0] + hours[1] / 60.0)}".to_f
      else
        hours = "#{"%.2f" %  (hours[0] / 60.0)}".to_f
      end
      
      project = YAML.load_file('./config/project_lookup.yml')[row[3]]
      
      t = TimeEntry.new(
        :project_id => Project.find_by_name(project)["id"], 
        :spent_on => Date.new(*day1), 
        :hours => hours, 
        :activity_id => Activities[:development], 
        :comments => row[4] || row[3], 
        :started_at => Time.new(*started_at), 
        :ended_at => Time.new(*ended_at)
      )
      time_entries << t
    end
    time_entries
  end
  
end