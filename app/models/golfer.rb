class Golfer < ActiveRecord::Base

  has_many :scores
  has_many :holes, through: :scores

  def self.create(name, age, player_handicap=nil)
    golfer = self.new
    golfer.name = name
    golfer.age = age
    if Golfer.find_by(name: name)
      puts "Looks like you are alreadt registered!"
    else
      golfer.create
    end  # ends if Golfer.find_by loop
  end  # ends self.create method


  def self.total_score_by_player(golferid)
    Score.where(golfer_id: golferid).sum(:strokes)
  end  # ends self.total_score_by_player method

  def self.player_with_best_score
    winner = Score.group(:golfer_id).sum(:strokes).min_by {|k,v| v}
    puts "#{Golfer.find(winner[0]).name} won with a score of #{winner[1]}"
  end  # ends self.top_score method

  def self.player_with_worst_score
    loser = Score.group(:golfer_id).sum(:strokes).max_by {|k,v| v}
    puts "#{Golfer.find(loser[0]).name} won the 'Sean Vesey' award with the worst score of #{loser[1]}"
  end  # ends self.top_score method


end  # end Golfer class
