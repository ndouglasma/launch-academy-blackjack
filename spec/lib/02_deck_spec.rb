require "spec_helper"
require_relative "../../lib/card"
require_relative "../../lib/deck"

# SUITS = ["♦", "♣", "♠", "♥"]
# RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K", "A"]

describe Deck do
  let(:green_deck) { Deck.create_and_shuffle_deck(RANKS, SUITS) }

  describe ".new" do
    it "is a Deck object" do
      expect(green_deck).to be_a(Deck)
    end

    it "is an array" do
      expect(green_deck.card_deck).to be_a(Array)
    end

    it "is an array of cards" do
      expect(green_deck.card_deck).to all(be_an(Card))
    end

    it "is an array of 52 cards" do
      expect(green_deck.card_deck.length).to eq(52)
    end

    it "creates unique cards" do
      expect(green_deck.card_deck.uniq.size).to eq 52
    end
  end

  describe "#card_deck" do
    it "has an attribute reader for card_deck" do
      expect(green_deck.card_deck[0]).to eq(green_deck.card_deck[0])
    end

    it "should not have a writer for card_deck" do
      expect{ green_deck.card_deck = 2 }.to raise_error(NoMethodError)
    end
  end

  let(:blue_deck) { Deck.create_and_shuffle_deck(RANKS, SUITS) }
  describe "#draw_card!" do
    context "draw a card" do
      it "draws only 1 card and the length to be 51" do
        expect(blue_deck.draw_card!).to be_a(Card)
        expect(blue_deck.card_deck.length).to eq(51)
      end
    end

    let(:red_deck) do
      red_deck = Deck.create_and_shuffle_deck(RANKS, SUITS)
      card1 = red_deck.draw_card!
      card2 = red_deck.draw_card!
      card3 = red_deck.draw_card!
      card4 = red_deck.draw_card!
      card5 = red_deck.draw_card!
      red_deck
    end

    context "draw 5 cards" do
      it "draws 5 cards and the length to be 47" do
        expect(red_deck.card_deck.length).to eq(47)
      end
    end
  end
end
