require 'json'

module Mobile
  class Catalogs
    attr_accessor :params, :response, :data

    def self.perform(params)
      new(params)
    end

    def initialize(params)
      @params = params
      @data = nil
      @response = []
      parsing_data!
    end

    private

    def parsing_data!
      browser = Mechanize.new
      aliases = ['Linux Firefox', 'Windows Chrome', 'Mac Safari']
      browser.user_agent_alias = aliases.sample

      start_date = Date.strptime(params.mobile_make.start_from.to_s, '%Y%m')
      date_range = (start_date..DateTime.now).map {|date| "#{date.to_s[0..-4]}"}.uniq

      date_range.each do |date|
        year = date.split('-')[0]
        month = date.split('-')[1]

        page_first = browser.get("https://www.mobile.de/svc/catalog/?mk=#{params.mobile_make_id}&md=#{params.model_id}&fr=#{month}-#{year}")
        body = page_first.body
        @data = JSON.parse(body)

        if data.present?
          data.each do |row|
            flush_to_db
          end
        else
          puts "#{month}-#{year} NOT EXISTS"
        end
      end
    end

    def flush_to_db
      ActiveRecord::Base.transaction do
        hash_data = { mobile_make_id: params.mobile_make_id,
                      model_id: params.model_id,
                      catalogId: data.first['catalogId'],
                      vehicleCategory: data.first['attributes']['vehicleCategory'],
                      category: data.first['attributes']['category'],
                      features: data.first['attributes']['features'],
                      modelDescription: data.first['attributes']['modelDescription'],
                      equipmentVersion: data.first['attributes']['equipmentVersion'],
                      doorCount: data.first['attributes']['doorCount'],
                      emissionClass: data.first['attributes']['emissionClass'],
                      fuel: data.first['attributes']['fuel'],
                      power: data.first['attributes']['power'],
                      transmission: data.first['attributes']['transmission'],
                      climatisation: data.first['attributes']['climatisation'],
                      numSeats: data.first['attributes']['numSeats'],
                      cubicCapacity: data.first['attributes']['cubicCapacity'],
                      interiorType: data.first['attributes']['interiorType'],
                      make: data.first['attributes']['make'],
                      model: data.first['attributes']['model'],
                      consumptionUnit: data.first['attributes']['envkv']['consumptionUnit'],
                      consumptionInner: data.first['attributes']['envkv']['consumptionInner'],
                      consumptionOuter: data.first['attributes']['envkv']['consumptionOuter'],
                      consumptionCombined: data.first['attributes']['envkv']['consumptionCombined'],
                      carbonDioxydEmission: data.first['attributes']['envkv']['carbonDioxydEmission'],
                      compliant: data.first['attributes']['envkv']['compliant'],
                      productionPeriod: data.first['productionPeriod'],
                      log: data.first }

        MobileCatalog.create!(hash_data)
      end
    end
  end
end
