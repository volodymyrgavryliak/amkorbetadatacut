require 'json'

module Mobile
  class Makes
    attr_accessor :file_path, :response, :data

    def self.perform
      new
    end

    def initialize
      @file_path = File.join(Rails.root, 'app/services/mobile', 'data.txt')
      @data = nil
      @response = []
      parsing_data!
    end

    private

    def parsing_data!
      datas = JSON.parse File.read(file_path)
      @data = datas['makes'].sort_by { |k| k[:i] }

      flush_to_db unless MobileMake.any?
      @response = MobileMake.all
    end

    def flush_to_db
      ActiveRecord::Base.transaction do
        data.each { |row| MobileMake.where(make_i: row['i'],
                                           make_n: row['n'],
                                           start_from: row['start_from']).first_or_create }
      end
    end
  end
end
