require "spec_helper"
require_relative "../../lib/card"
require_relative "../../lib/deck"
require_relative "../../lib/hand"

describe Hand do
  let(:player_hand) { Hand.new }

  describe ".new" do
    it "is a Hand object" do
      expect(player_hand).to be_a(Hand)
    end

    it "contains an array" do
      expect(player_hand.cards).to be_a(Array)
    end

    it "contains a numerical score" do
      expect(player_hand.score).to be_a(Integer)
    end

    it "array is empty" do
      expect(player_hand.cards.length).to eq(0)
    end

    it "score is initialized to 0" do
      expect(player_hand.score).to eq(0)
    end
  end

  describe "#cards=" do
    it "has a writer for cards" do
      expect { player_hand.cards = "test" }.to_not raise_error
    end
  end

  describe "#cards" do
    it "has a reader for cards" do
      player_hand.cards = "test"
      expect(player_hand.cards).to eq("test")
    end
  end

  describe "#score=" do
    it "has a writer for score" do
      expect { player_hand.score = 700 }.to_not raise_error
    end
  end

  describe "#score" do
    it "has a reader for score" do
      player_hand.score = 700
      expect(player_hand.score).to eq(700)
    end
  end

  describe "#add_cards_to_hand" do
    new_deck = Deck.create_and_shuffle_deck(RANKS, SUITS)
    card1 = new_deck.draw_card!
    card2 = new_deck.draw_card!
    new_hand = Hand.new
    new_hand.add_cards_to_hand(card1, card2)

    context "working with 2 cards" do
      it "hand contains 2 card objects" do
        expect(new_hand.cards[0]).to be_a(Card)
        expect(new_hand.cards[1]).to be_a(Card)
        expect(new_hand.cards.length).to eq(2)
      end
    end

    context "working with 2 cards" do
      it "deck has 2 less cards" do
        expect(new_deck.card_deck.length).to eq(50)
        expect(new_deck.card_deck).not_to include(card1)
        expect(new_deck.card_deck).not_to include(card2)
        expect(new_hand.cards.length).to eq(2)
      end
    end
  end

  describe "#calculate_score" do
    let(:non_face_hand) do
      non_face_hand = Hand.new
      non_face_hand.add_cards_to_hand(Card.new(10, "♦"), Card.new(2, "♥"))
      non_face_hand
    end

    context "#calculate_score - non face cards" do
      it "score = 12" do
        expect(non_face_hand.calculate_score).to eq(non_face_hand.cards[0].rank + non_face_hand.cards[1].rank)
      end
    end

    let(:face_hand) do
      face_hand = Hand.new
      face_hand.add_cards_to_hand(Card.new("J", "♦"), Card.new("Q", "♥"))
      face_hand
    end

    context "#calculate_score - face cards" do
      it "score = 20" do
        expect(face_hand.calculate_score).to eq(20)
      end
    end

    let(:two_aces_hand) do
      two_aces_hand = Hand.new
      two_aces_hand.add_cards_to_hand(Card.new("A", "♦"), Card.new("A", "♥"))
      two_aces_hand
    end

    context "#calculate_score - two aces" do
      it "score = 12" do
        expect(two_aces_hand.calculate_score).to eq(12)
      end
    end

    let(:three_aces_hand) do
      three_aces_hand = Hand.new
      three_aces_hand.add_cards_to_hand(Card.new("A", "♦"), Card.new("A", "♥"))
      three_aces_hand.add_cards_to_hand(Card.new("A", "♥"))
      three_aces_hand
    end

    context "#calculate_score - three aces" do
      it "score = 13" do
        expect(three_aces_hand.calculate_score).to eq(13)
      end
    end

    let(:winning_hand) do
      winning_hand = Hand.new
      winning_hand.add_cards_to_hand(Card.new("A", "♦"), Card.new("Q", "♥"))
      winning_hand
    end

    context "#calculate_score - winning hand 1" do
      it "score = 21" do
        expect(winning_hand.calculate_score).to eq(21)
      end
    end

    let(:bust_hand) do
      bust_hand = Hand.new
      bust_hand.add_cards_to_hand(Card.new("A", "♦"), Card.new("Q", "♥"))
      bust_hand.add_cards_to_hand(Card.new("A", "♥"))
      bust_hand
    end

    context "#calculate_score - bust hand" do
      it "score = 22" do
        expect(bust_hand.calculate_score).to eq(22)
      end
    end

    let(:winning_hand1) do
      winning_hand1 = Hand.new
      winning_hand1.add_cards_to_hand(Card.new("Q", "♦"), Card.new("Q", "♥"))
      winning_hand1.add_cards_to_hand(Card.new("A", "♥"))
      winning_hand1
    end

    context "#calculate_score - winning hand 2" do
      it "score = 21" do
        expect(winning_hand1.calculate_score).to eq(21)
      end
    end

    let(:winning_hand2) do
      winning_hand2 = Hand.new
      winning_hand2.add_cards_to_hand(Card.new(8, "♦"), Card.new(2, "♥"))
      winning_hand2.add_cards_to_hand(Card.new("A", "♥"))
      winning_hand2
    end

    context "#calculate_score - winning hand 3" do
      it "score = 21" do
        expect(winning_hand2.calculate_score).to eq(21)
      end
    end

    let(:short_hand) do
      short_hand = Hand.new
      short_hand.add_cards_to_hand(Card.new(8, "♦"), Card.new("Q", "♥"))
      short_hand.add_cards_to_hand(Card.new("A", "♥"))
      short_hand
    end

    context "#calculate_score - short by 2" do
      it "score = 19" do
        expect(short_hand.calculate_score).to eq(19)
      end
    end

    let(:short_hand1) do
      short_hand1 = Hand.new
      short_hand1.add_cards_to_hand(Card.new("A", "♦"), Card.new(8, "♥"))
      short_hand1.add_cards_to_hand(Card.new("A", "♥"))
      short_hand1
    end

    context "#calculate_score - short by 1" do
      it "score = 20" do
        expect(short_hand1.calculate_score).to eq(20)
      end
    end

    let(:bust_hand1) do
      bust_hand1 = Hand.new
      bust_hand1.add_cards_to_hand(Card.new("Q", "♦"), Card.new("Q", "♥"))
      bust_hand1.add_cards_to_hand(Card.new("Q", "♠"), Card.new("A", "♠"))
      bust_hand1
    end

    context "#calculate_score - bust to 31" do
      it "score = 31" do
        expect(bust_hand1.calculate_score).to eq(31)
      end
    end

    let(:six_card_hand) do
      six_card_hand = Hand.new
      six_card_hand.add_cards_to_hand(Card.new(2, "♦"), Card.new(2, "♥"))
      six_card_hand.add_cards_to_hand(Card.new(2, "♠"), Card.new(2, "♣"))
      six_card_hand.add_cards_to_hand(Card.new("Q", "♠"), Card.new("A", "♠"))
      six_card_hand
    end

    context "#calculate_score - six card hand" do
      it "score = 19" do
        expect(six_card_hand.calculate_score).to eq(19)
      end
    end
  end
end
