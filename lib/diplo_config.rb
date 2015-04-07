require 'config_reader'

class DiploConfig < ConfigReader
  self.config_file = File.exists?("config/site.yml") ? "config/site.yml" : "config/site.heroku.yml"
end
