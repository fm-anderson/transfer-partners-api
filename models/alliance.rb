require 'json'

class Alliance
    @data = JSON.parse(File.read('db.json'))

    def self.all_airlines_with_alliance
        all_airlines = []
        
        @data['alliances'].each do |alliance_name, airlines|
          airlines.each do |airline|
            airline_with_alliance = airline.merge({ 'alliance' => alliance_name })
            all_airlines << airline_with_alliance
          end
        end
        
        all_airlines
    end

    def self.find_alliance(name)
        formatted_name = name.gsub('-', ' ')
        @data['alliances'][formatted_name]
    end

    def self.all
      @data['alliances'].keys
    end
  
    def self.all_data
      @data['alliances']
    end
  
  def self.find(alliance_name)
    alliance_name_downcased = alliance_name.downcase
    airlines = @data['alliances'][alliance_name_downcased]
    { alliance_name_downcased => airlines } if airlines
  end
  
  def self.find_airline(alliance_name, airline_name)
    alliance = self.find(alliance_name)
    alliance&.dig(alliance_name.downcase)&.find { |airline| airline['name'] == airline_name }
  end
end
