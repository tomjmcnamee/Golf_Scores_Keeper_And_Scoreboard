class Hole < ActiveRecord::Base

  belongs_to :courses
  has_many :scores
  has_many :golfers, through: :scores

end  # end Hole class
