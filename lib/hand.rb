class Hand
  attr_accessor :cards, :score

  def initialize
    @cards = []
    @score = 0
  end

  def add_cards_to_hand(card1, card2=nil)
    @cards.push(card1)
    if !card2.nil?
      @cards.push(card2)
    end
  end

  def calculate_score
    score = 0

    @cards.each do |card|
      if card.face_card?
        score += 10
      elsif card.ace_card?
        if score <= 10
          score += 11
        else
          score += 1
        end
      else
        score += card.rank
      end
    end

    @score = score
  end
end
