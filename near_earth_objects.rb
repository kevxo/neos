require 'faraday'
require 'figaro'
require 'pry'
require_relative 'asteroid_data'
# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('config/application.yml', __dir__))
Figaro.load

class NearEarthObjects
  def self.find_neos_by_date(date)
    AsteroidData.new(date).display_asteroid_info
  end
end
