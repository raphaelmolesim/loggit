require 'net/http'
require 'net/https'
require 'json'
require 'yaml'
require 'nokogiri'

class Redmine
  
  def initialize url
    @url = url
    @header = {
      'Content-Type' =>'application/x-www-form-urlencoded', 
      'X-Redmine-API-Key' => Loggit[:apikey]
    }
  end
  
  def create_time_entry! time_entry    
    uri = URI.parse("#{@url}/projects/#{time_entry.project_name}/time_entries")
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    post_data = time_entry.to_h.
      inject({}) { |r, (k, v)| r["time_entry[#{k}]"] = v ; r }
    MyLogger.puts post_data
    
    req = Net::HTTP::Post.new(uri.path, @header)
    req.set_form_data(post_data)
    res = https.request(req)
    
    MyLogger.puts "URI: #{uri}"
    MyLogger.puts "(#{res.code}) > #{res.body}"
    
    raise code_error res if res.code != "302"
    raise message_error res if not res.body =~ response_expected
    
    true
  end
  
  def load_projects 
    current_page = 0
    return @all_projects if @all_projects
    @all_projects = []
    
    begin
      current_page += 1
      params = { limit: 100, page: current_page }
      query_string = "?" + params.map { |k, v| "#{k}=#{v}" }.join("&")
      uri = URI.parse("#{@url}/projects.json#{query_string}")
    
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
        
      req = Net::HTTP::Get.new(uri.request_uri, @header)
      res = https.request(req)
      
      json = JSON res.body
      @all_projects += json['projects']
    
      MyLogger.puts "URI: #{uri}"
      
      raise projects_code_error res if res.code != "200"
      
    end while json['total_count'] > params[:limit] * current_page
    
    @all_projects
  end
  
  def response_expected
    /<html><body>You are being <a href=\".*\">redirected<\/a>.<\/body><\/html>/
  end
  
  def projects_code_error res
    "Response Code not match 200 => Code: #{res.code} | Body: #{res.body}"
  end
  
  def code_error res
    "Response Code not match 302 => Code: #{res.code} | Body: #{res.body}"
  end
  
  def message_error res
    "Response Message not match => Code: #{res.code} | Body: #{res.body}"
  end
  
  class << self
    
    def instance
      @instance ||= Redmine.new(Loggit[:url])
      @instance
    end
    
  end
  
end