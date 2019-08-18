class Score < ActiveRecord::Base

  belongs_to :hole
  belongs_to :golfer


  def self.highest_average_stroke_count
    # The following works to print out the average stroke count per hole
    #total_strokes_per_hole.each { |holenum, totalstrokes| av = (totalstrokes/15.to_f).round(2); puts "Avrage strokes for hole #{holenum} was #{av}"}
  end  # ends self.highest_average_stroke_count

  def self.hole_details_with_player_strokes(player_id)
    # player_name = Golfer.find(player_id).name
    # puts "Scorecard belonging to #{player_name}:"
    # players_scorecard = Score.where(golfer_id: player_id)
    # scorecard_hash = {}
    # player_scorecard.each do |obj|
    #   scorecard_hash[Hole.find(obj.hole_id).hole_number] = obj.strokes
    # end  # ends play_scorecard each loop
    # scorecard_hash.each do |hole, strks|
    #   #puts "Hole number #{hole}: par #{Hole.find(obj.hole_id).par}:  shot #{obj.strokes}"
    # end
    scores = Golfer.find(player_id).scores
    puts "Scorecard for #{Golfer.find(player_id).name}:"
    scores.each do |score_obj|
      hole_number = Hole.find(score_obj.hole_id).hole_number
      par = Hole.find(score_obj.hole_id).par
      puts "Hole #{hole_number}(par #{par}): #{score_obj.strokes}"
    end  #ends each
  end #  ends self.hole_details_with_player_strokes

end  # end Score class
