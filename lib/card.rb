class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def ace_card?
    @rank == "A"
  end

  def face_card?
    ["J", "Q", "K"].include?(@rank)
  end
end
