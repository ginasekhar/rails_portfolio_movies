class Movie < ApplicationRecord
    scope :age_appropriate_for_me, -> (user_age) {where(rating: get_ratings(user_age))}

    validates :title, presence: true
    validates :description, length: { maximum: 1000 }
    validates :rating, presence: true
    validates_inclusion_of :rating, :in => %w(G PG PG-13 R),
    :message => "{{value}} is not a valid rating"
    #validates :rating, inclusion: { in: ["G", "PG", "PG-13", "R"] }
    #:in => ["G", "PG", "PG-13", "R"]
                #inclusion: { in: ("G" PG PG-13 R) }

  
    def self.get_ratings(user_age)
        case user_age 
        when 0..8
            appropriate_ratings = ["G"] 
        when 9..12
            appropriate_ratings = ["G", "PG"] 
        when 13..16
            appropriate_ratings = ["G", "PG", "PG-13"] 
        else
            appropriate_ratings = ["G", "PG", "PG-13", "R"]
        end
        appropriate_ratings
    end
end
