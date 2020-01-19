class Movie < ApplicationRecord
    scope :age_appropriate_for_me, -> (user_age) {where(rating: get_ratings(user_age))}

    has_many :showings
    has_many :tickets, through: :showings

    before_destroy :check_for_showings

    accepts_nested_attributes_for :showings, :reject_if => :all_blank

    validates :title, presence: true, uniqueness: true
    validates :release_date, presence: true
    
    validates :description, length: { maximum: 1000 }

    validates :rating, presence: true
    validates_inclusion_of :rating, :in => %w(G PG PG-13 R),:message => "{{value}} is not a valid rating"
    
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
    
    private

    def check_for_showings
      if self.showings.any? 
        errors[:base] << "cannot delete movie that has showings"
      end
    end
    # def showings_attributes=(showings_hash)
    #     binding.pry
    #     showings_hash.values.each do |showing_attribute|
    #       if  showing_attribute[:show_date].present? && showing_attribute[:show_time].present?
    #         showing = Showing.find_or_create_by(showing_attribute)
    #         self.showings << showing
    #       end
    #     end
    # end
end
