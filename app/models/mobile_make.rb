class MobileMake < ActiveRecord::Base
  has_many :mobile_models, class_name: 'MobileModel', primary_key: 'make_i'
end
