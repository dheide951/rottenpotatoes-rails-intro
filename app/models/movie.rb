class Movie < ActiveRecord::Base
  
  def get_rating
    
    return self.rating
    
  end
  
end
