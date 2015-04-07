require 'config_reader'

class DiploConfig < ConfigReader
  # self.config_file = @config_file
  self.config_file = File.exists?("site.yml") ? "site.yml" : "site.heroku.yml"
end
