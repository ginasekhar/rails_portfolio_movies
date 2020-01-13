class Movie < ApplicationRecord

    def age_appropriate_for_me
        case self.age 
        when 0..8
            appropriate_ratings = ["G"] 
        when 9..12
            appropriate_ratings = ["G", "PG"] 
        when 13..16
            appropriate_ratings = ["G", "PG", "PG-13"] 
        else
            appropriate_ratings = ["G", "PG", "PG-13", "R"]
        end
        Movies.where(rating: appropriate_ratings)
    end
end
