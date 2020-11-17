require_relative 'api_data'

class AsteroidData
  attr_reader :parsed_asteroids_data, :date
  def initialize(date)
    @date = date
    @parsed_asteroids_data = ApiData.retrieve_api_data(@date)
  end

  def largest_astroid_diameter
    @parsed_asteroids_data.map do |astroid|
      astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    end.max { |a, b| a <=> b }
  end

  def total_number_of_astroids
    @parsed_asteroids_data.count
  end

  def formatted_asteroid_data
    @parsed_asteroids_data.map do |astroid|
      {
        name: astroid[:name],
        diameter: "#{astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
        miss_distance: "#{astroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
      }
    end
  end

  def display_asteroid_info
    {
      astroid_list: formatted_asteroid_data,
      biggest_astroid: largest_astroid_diameter,
      total_number_of_astroids: total_number_of_astroids
    }
  end
end
