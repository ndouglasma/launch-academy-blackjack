require_relative "card"

class Deck
  attr_reader :card_deck
  
  def initialize(card_deck)
    @card_deck = card_deck
  end

  def self.create_and_shuffle_deck(ranks,suits)
    card_deck=[]

    suits.each do |suit|
      ranks.each do |rank|
        card_deck.push(Card.new(rank, suit))
        #puts "#{rank} #{suit}"
      end
    end

    #puts card_deck.count
    card_deck.shuffle!
    Deck.new(card_deck)
  end

  def draw_card!
    @card_deck.pop
  end
end
