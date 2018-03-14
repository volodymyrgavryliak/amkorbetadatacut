class MobileModel < ActiveRecord::Base
  belongs_to :mobile_make, class_name: 'MobileMake', primary_key: 'make_i'
end
