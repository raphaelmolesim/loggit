class Activities
  class << self
    def [] key 
      yaml_config = YAML.load_file('./config/activities.yml')
      yaml_config['activities'][key.to_s]
    end
  end
end