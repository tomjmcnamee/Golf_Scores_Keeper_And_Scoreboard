require 'pry'
class GolferApp

  attr_reader :selection_number

  ## The below line hides all DB Call details
  ActiveRecord::Base.logger = nil

  def call
    puts "Hello and Welcome!"

# The following 2 lines make the app run until the user chooses to 'exit'
    topmenu_response = ""
    until topmenu_response.downcase == "exit" do


      
# Primary Menu of choices presented to the user      
      puts "\n Select from the below:"
      puts "1 - See total score for a single player"
      puts "2 - See ALL scores"
      puts "3 - See the WINNING player and stroke count"
      puts "4 - See the biggest LOSER and stroke count"
      puts "5 - See players scorecard"
      puts "6 - Create a new Golfer record for yourself"
      puts "7 - Add your scores"
      puts "8 - Modify a score"
      puts "9 - Delete a Golfer record"
      puts "or type 'exit'"

# Accepts user's choice from first menu
      topmenu_response = gets.chomp
      puts "\n"

# Case statement to act on their choice
      case topmenu_response.downcase
      when "1"
        golfer_hash = Golfer.print_list_of_valid_golfers(Golfer.all)
        
        puts "Which player's score would you like to see?  Submit their corrosponding NUMBER"
        selection_number = gets.chomp    

        while selection_number.to_i <= 0 || selection_number.to_i > golfer_hash.length do
          puts "'#{selection_number}' is not a valid selection, try again."
          selection_number = gets.chomp 
        end  # Ends "WHILE input is invalid" loop

        # for the above 4 lines, need #method in the GolferApp class



        #def self.verify_golfer_selection_was_valid(golfer_hash)
        #end


        # selection_number must be instance attribute




        selection_obj = Golfer.find_by(name: golfer_hash[selection_number.to_i])
        puts "------------#{selection_obj.name}'s total score was #{Golfer.total_score_by_player(selection_obj.id)}----."
    
      when "2"
        Golfer.all.each { |golfer| puts "#{golfer.id}:  #{golfer.name} shot a #{Golfer.total_score_by_player(golfer.id)}"}
      
      
      
      when "3"
        Golfer.player_with_best_score



      when "4"
        Golfer.player_with_worst_score



      when "5"
        golfer_hash = Golfer.print_list_of_valid_golfers(Golfer.all)

        puts "Which player's scorecard would you like to see?  Submit their corrosponding NUMBER"
        selection_number = gets.chomp

        #Below makes the user resubmit option if they didnt make valid selection
        while selection_number.to_i <= 0 || selection_number.to_i > golfer_hash.length do
          puts "'#{selection_number}' is not a valid selection, try again."
          selection_number = gets.chomp
        end
        
        selection_obj = Golfer.find_by(name: golfer_hash[selection_number.to_i])
        Score.hole_details_with_player_strokes(selection_obj.id)

      when "6"
        Golfer.new_golfer_verify_and_save
      
      when "7"

        golfer_hash = Golfer.print_list_of_valid_golfers(Golfer.all)
       
        puts "Submit the NUMBER next to your name"
        selection_number = gets.chomp

        while selection_number.to_i <= 0 || selection_number.to_i > golfer_hash.length do
          puts "'#{selection_number}' is not a valid selection, try again."
          selection_number = gets.chomp
        end  # ends while loop to make user try again to submit a valid option
          
          selection_obj = Golfer.find_by(name: golfer_hash[selection_number.to_i])
          Golfer.add_scores(selection_obj)
          puts "Total score for the round: #{Golfer.total_score_by_player(selection_obj.id)}"
          
      
      when "8"
 
        golfer_hash = Golfer.print_list_of_valid_golfers(Golfer.all)

        puts "Submit the NUMBER next to your name"
        selection_number = gets.chomp

        while selection_number.to_i <= 0 || selection_number.to_i > golfer_hash.length do
          puts "'#{selection_number}' is not a valid selection, try again."
          selection_number = gets.chomp
        end  # ends while loop to make user try again to submit a valid option
          
        selection_obj = Golfer.find_by(name: golfer_hash[selection_number.to_i])

        counter = 0
        score_hash = {}
        score_selection_objs = selection_obj.scores
        score_selection_objs.each { |score| counter += 1; score_hash[counter] = score.id } 
        
        # Prints all the selected users scores with corrosponding temporary identifier
        score_hash.each { |tempid,scoreid|  puts "#{tempid}: Hole number #{selection_obj.scores.find(scoreid).hole.hole_number}, current score is #{score_selection_objs.find(scoreid).strokes}"}
        
        puts "Submit the LINE NUMBER of the score you'd like to change"
        score_selection_number = gets.chomp

        while score_selection_number.to_i <= 0 || score_selection_number.to_i > score_hash.length
          puts "'#{score_selection_number}' is not a valid selection, try again."
          score_selection_number = gets.chomp
        end  # ends while loop to make user picked a valid score to change

        score_obj_to_change = score_selection_objs.find(score_hash[score_selection_number.to_i])
        
        puts "Current stroke count = #{score_obj_to_change.strokes}"
        puts "What would you like to change this to?"
        new_stroke_count = gets.chomp.to_i

        Score.change_and_save_score(score_selection_objs,score_hash,score_selection_number,new_stroke_count)


      when "9"  # Top menu response = "Delete a Golfer record"
        golfer_hash = Golfer.print_list_of_valid_golfers(Golfer.all)
        
        puts "Which Golfer Record would you like to delete?  Submit their corrosponding NUMBER"
        selection_number = gets.chomp

        while selection_number.to_i <= 0 || selection_number.to_i > golfer_hash.length do
          puts "'#{selection_number}' is not a valid selection, try again."  
          selection_number = gets.chomp
        end  ## Ends While loop for correct selection
        
        selection_obj = Golfer.find_by(name: golfer_hash[selection_number.to_i])
    
        Golfer.delete_golfer_and_scores(selection_obj)
      
      when "exit"

      else  #ELSE FOR CASE STATEMENT
        puts "'#{topmenu_response}' is not a valid selection!"

      end  # ends CASE STATEMENT
  # If statement to retain top_menu 'exit' selection or ask user if they want to restart
      if topmenu_response.downcase == "exit"
      else
        puts "\n hit <enter> start over, or 'exit' to exit"
        topmenu_response = gets.chomp
      end  # ends if statement
    end  # ends until loop
# User chooses to exit the application 
    puts "\n Goodbye! \n" 
  end  # ends call method


  
end  # ends GolferApp
