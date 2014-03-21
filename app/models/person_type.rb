class PersonType < ActiveRecord::Base
  has_one :favorite  
  has_one :item
  
end
