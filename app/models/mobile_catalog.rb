class MobileCatalog < ActiveRecord::Base
  serialize :power, Hash
  serialize :make, Hash
  serialize :model, Hash
  serialize :productionPeriod, Hash
  serialize :log, Hash
end
