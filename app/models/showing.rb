class Showing < ApplicationRecord

  belongs_to :movie
  has_many :tickets
  has_many :users, through: :tickets
  
  before_destroy :check_for_tickets

  validates :show_time, presence: true
  validates :show_date, presence: true
  validate :show_date_cannot_be_in_the_past

  
  def total_tickets
    self.tickets.count
  end

  private

  def show_date_cannot_be_in_the_past
    if show_date.present? && show_date < Date.today
      errors.add(:show_date, "can't be in the past")
    end
  end    

  def check_for_tickets
    if self.tickets.any? 
      errors[:base] << "cannot delete showing that has tickets"
    end
  end
end
