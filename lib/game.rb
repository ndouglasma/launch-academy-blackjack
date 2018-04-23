require_relative "deck"
require_relative "hand"

SUITS = ["♦", "♣", "♠", "♥"]
RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K", "A"]

class Game
  attr_accessor :player_hand, :dealer_hand, :winner, :card_deck

  def initialize
    @card_deck = Deck.create_and_shuffle_deck(RANKS, SUITS)
    @player_hand = nil
    @dealer_hand = nil
    @winner = nil
  end

  def initial_play(contestant)
    card1 = @card_deck.draw_card!
    card2 = @card_deck.draw_card!
    puts "#{contestant} Card1: #{card1.rank} #{card1.suit}"
    puts "#{contestant} Card2: #{card2.rank} #{card2.suit}"
    hand = Hand.new
    hand.add_cards_to_hand(card1, card2)
    score = hand.calculate_score
    puts "#{contestant} Score: #{score}"

    if contestant == "Player"
      @player_hand = hand
    else
      @dealer_hand = hand
    end
  end

  def hit_play(contestant)
    card = @card_deck.draw_card!
    puts "#{contestant} Card: #{card.rank} #{card.suit}"
    if contestant == "Player"
      @player_hand.add_cards_to_hand(card)
      score = @player_hand.calculate_score
      @player_hand.score = score
    else
      @dealer_hand.add_cards_to_hand(card)
      score = @dealer_hand.calculate_score
      @dealer_hand.score = score
    end

    puts "**#{contestant} Score: #{score}***\n"
  end

  def find_winner
    winner = ""

    puts "****"
    puts @player_hand.score
    puts @dealer_hand.score if !dealer_hand.nil?
    puts "****"

    if @player_hand.score > 21 #will capture initial hand if player busts
      winner = "Player busts!  Dealer"
    elsif @player_hand.score == 21
      if @dealer_hand.score == 21
        winner = "Tie"
      else
        winner = "Player"
      end
    else #player is < 21
      if @dealer_hand.score > 21
        winner = "Dealer busts!  Player"
      elsif @player_hand.score == @dealer_hand.score
        winner = "Tie"
      elsif @player_hand.score > @dealer_hand.score
        winner = "Player"
      else
        winner = "Dealer"
      end
    end

    if winner == "Tie"
      @winner = "It's a tie."
    else
      @winner = "#{winner} wins."
    end

    puts "****AND THE WINNER IS: #{@winner}****\n"
  end
end
