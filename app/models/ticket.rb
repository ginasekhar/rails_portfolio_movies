class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :showing

  #scope :unexpired_tickets, -> { joins(:showing).where("showing.show_date >= ?", Date.today )
  scope :my_tickets, -> (me) { where(user: me) }
  
  validates_inclusion_of :ticket_type, :in => %w(Adult Child Senior Student),:message => "{{value}} is not a valid type"
  
end
