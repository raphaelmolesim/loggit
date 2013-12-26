class Loggit 
  LOGGIT_ENV = 'development'
  
  class << self
    def [] key 
      yaml_config = YAML.load_file('./config/loggit.yml')
      MyLogger.puts yaml_config.inspect
      yaml_config['loggit'][LOGGIT_ENV][key.to_s]
    end
  end
end

