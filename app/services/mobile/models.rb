require 'json'

module Mobile
  class Models
    attr_accessor :params, :data, :response

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
      page_first = browser.get("https://www.mobile.de/svc/r/models/#{params.make_i}")
      body = page_first.body
      @data = JSON.parse(body)['models']
      flush_to_db
      @response = MobileModel.all
    end

    def flush_to_db
      ActiveRecord::Base.transaction do
        data.each { |row| MobileModel.where(model_id: row['i'],
                                             model_n: row['n'],
                                             mobile_make_id: params.make_i).first_or_create }
      end
    end
  end
end
