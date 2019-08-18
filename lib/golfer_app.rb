
class GolferApp

  ## The below line hides all DB Call details
  ActiveRecord::Base.logger = nil

  def call
    puts "Hello and Welcome!"

# The following 2 lines make the app run until the user chooses to 'exit'
    topmenu_response = ""
    until topmenu_response.downcase == "exit" do
      
# Primary Menu of choices presented to the user      
      puts "\n Select from the below:"
      puts "1 - see total score for a single player"
      puts "2 - See ALL scores"
      puts "3 - see the WINNING player and stroke count"
      puts "4 - see the biggest LOSER and stroke count"
      puts "5 - see players scorecard"
      puts "or type 'exit'"

# Accepts user's choice from first menu
      topmenu_response = gets.chomp
      puts "\n"

# Case statement to act on their choice
      case topmenu_response.to_i
      when 1
# The following 4 lines lists player names with TEMPORARY number ids (from which the 
# app user will make their selection), then builds a hash with
# those temp IDs as keys, and corrosponing Golfer Objects as values
        counter = 0
        golfer_hash = {}
        Golfer.all.each { |golfer| counter += 1; golfer_hash[counter] = golfer.name }
        golfer_hash.each { |tempnumber, golfername| puts "#{tempnumber}:  #{golfername}"}

        # UNTIL statement to retry gathering input until the user makes a valid selection      
        selection_number = 0
        until selection_number.to_i > 0 && selection_number.to_i <= golfer_hash.length
          puts "Which player's score would you like to see?  Submit their corrosponding NUMBER"
          selection_number = gets.chomp
          selection_obj = Golfer.find_by(name: golfer_hash[selection_number.to_i])
      
          
          #IF statement to reject invalid selections
          if selection_number.to_i > 0 && selection_number.to_i <= golfer_hash.length
            puts "------------#{selection_obj.name}'s total score was #{Golfer.total_score_by_player(selection_obj.id)}----."
          else
            puts "'#{selection_number}' is not a valid selection, try again."
          end  # ends if statement about valid player number
        end  # ends until loop about valid player number
      
      
      
      when 2
        Golfer.all.each { |golfer| puts "#{golfer.id}:  #{golfer.name} shot a #{Golfer.total_score_by_player(golfer.id)}"}
      
      
      
      when 3
        Golfer.player_with_best_score



      when 4
        Golfer.player_with_worst_score



      when 5
    # The following 4 lines lists player names with TEMPORARY number ids from which the 
    # app user will make their selection, then builds a hash with
    # those temp IDs as keys, and corrosponing Golfer Objects as values
        counter = 0
        golfer_hash = {}
        Golfer.all.each { |golfer| counter += 1; golfer_hash[counter] = golfer.name }
        golfer_hash.each { |tempnumber, golfername| puts "#{tempnumber}:  #{golfername}"}

    # UNTIL statement to retry gathering input until the user makes a valid selection      
        selection_number = 0
        until selection_number.to_i > 0 && selection_number.to_i <= golfer_hash.length
          puts "Which player's scorecard would you like to see?  Submit their corrosponding NUMBER"
          selection_number = gets.chomp
          selection_obj = Golfer.find_by(name: golfer_hash[selection_number.to_i])
      
          #IF statement to reject invalid selections
          if selection_number.to_i > 0 && selection_number.to_i <= golfer_hash.length
            Score.hole_details_with_player_strokes(selection_obj.id)
          else
            puts "'#{selection_number}' is not a valid selection, try again."
          end  # Ends if statement to reject invalid selection
        end  # ends until loop about valid player number
      else
  # If statement to reject invalid top_menu selections and delay acting on a top_menu 'exit' selection
  # This option cant be a typical case "when" condition since the only valid selections are integers
        if topmenu_response.downcase == "exit"
        else
          puts "'#{topmenu_response}' is not a valid selection!"
        end  # ends if statement
      end  # ends case loop
  # If statement to retain top_menu 'exit' selection or ask user if they want to restart
      if 
        topmenu_response.downcase == "exit"
      else
        puts "\n hit <enter> start over, or 'exit' to exit"
        topmenu_response = gets.chomp
      end  # ends if statement
    end  # ends until loop
# User chooses to exit the application 
    puts "\n Goodbye! \n" 
  end  # ends call method


  


  
end  # ends GolferApp
