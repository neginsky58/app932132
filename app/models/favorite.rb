class Favorite < ActiveRecord::Base

  belongs_to :user  

  belongs_to :category  
  belongs_to :person_type  
  belongs_to :size  
  
end
