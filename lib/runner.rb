$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'time_entry'
require 'redmine'
require 'importer'
STDOUT.sync = true

importer = Importer.new
time_entries = importer.parse_csv ARGV[0]

time_entries.map(&:project_name).uniq.each do |project|
  puts " ====> Import to redmine: #{project}"
  
  project_entries = time_entries.select { |t| t.project_name == project }
  project_entries.each do |p| 
    puts "* Project: #{project} Date: #{p.spent_on} Duration: #{p.hours} Desc: #{p.full_description[0,60]}" 
  end
  redmine = Redmine.instance
  
  while true
    puts "==> Upload time entries now? (y or n)"
    begin
      system("stty raw -echo")
      str = STDIN.getc
    ensure
      system("stty -raw echo")
    end
    if (str.downcase == "y")
      project_entries.each do |time_entry|
        redmine.create_time_entry! time_entry
      end
      break
    elsif (str.downcase == "n")
      break
    end
  end
  
end