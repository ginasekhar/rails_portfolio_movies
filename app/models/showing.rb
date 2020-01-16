class Showing < ApplicationRecord

  belongs_to :movie
  has_many :tickets
  #has_many :users, through: :tickets
  
  def total_tickets
    self.tickets.count
  end
end
