require 'net/http'

module Mobile
  class Main
    def self.perform
      makes = Mobile::Makes.perform.response
      makes_data = makes.where.not(start_from: nil).first
      
      models_data = Mobile::Models.perform(makes_data).response

      Mobile::Catalogs.perform(models_data.first)
    end
  end
end
