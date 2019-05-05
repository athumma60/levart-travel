#Sets a model for reservations
class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :room
end
