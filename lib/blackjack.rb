require_relative "deck"
require_relative "hand"
require_relative "game"

input_play = "Y"

while input_play == "Y"
  puts "Welcome to Blackjack!"
  print "If you want to play, please enter 'Y'.  If not, enter 'N' ==> "
  input_play=gets.chomp.upcase
  puts "\n\n"

  if input_play == "Y"
    game_on = Game.new
    game_on.initial_play("Player")

    continue_play = true

    while continue_play && game_on.player_hand.score <= 21
      print "Hit or stand (H/S): "
      input_hit_or_stand = gets.chomp.upcase

      if input_hit_or_stand == "H"
        game_on.hit_play("Player")
      elsif input_hit_or_stand =="S"
        puts "\n"
        game_on.initial_play("Dealer")
        while game_on.dealer_hand.score < 17
          game_on.hit_play("Dealer")
        end
        continue_play = false
      else
        puts "You entered an invalid response.  Game over.  Please try again."
        continue_play = false
      end
    end

    puts game_on.find_winner
  elsif input_play == "N"
    puts "Thanks.  Goodbye."
    input_play = "N"
  else
    input_play = "Y"
    puts "You entered an invalid response.  Please try again."
  end
end
