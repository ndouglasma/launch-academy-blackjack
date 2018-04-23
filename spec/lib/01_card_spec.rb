require "spec_helper"
require_relative "../../lib/card"

describe Card do
  let(:two_diamond_card) { Card.new(2, "♦") }
  let(:ace_card) { Card.new("A", "♥") }
  let(:face_card) { Card.new("K", "♥") }
  let(:false_card) {"False card"}

  context "#initialize" do
    it "is a Card object" do
      expect(two_diamond_card).to be_a(Card)
    end

    it "is not a Card object" do
      expect(false_card).not_to be_a(Card)
    end

    it "Card has a rank" do
      expect(two_diamond_card.rank).to eq(2)
    end

    it "Card has a suit" do
      expect(two_diamond_card.suit).to eq ("♦")
    end
  end

  context "rank" do
    it "should have a reader for rank" do
      expect(two_diamond_card.rank).to eq(2)
    end

    it "should not have a writer for rank" do
      expect{ two_diamond_card.rank = 2 }.to raise_error(NoMethodError)
    end
  end

  context "suit" do
    it "should have a reader for suit" do
      expect(two_diamond_card.suit).to eq("♦")
    end

    it "should not have a writer for suit" do
      expect{ two_diamond_card.suit = "♦" }.to raise_error(NoMethodError)
    end
  end

  context "ace_card?" do
    it "returns true if the card is an Ace" do
      expect(ace_card.ace_card?).to eq(true)
    end

    it "returns false if the card is not an Ace" do
      expect(two_diamond_card.ace_card?).to eq(false)
    end
  end

  context "face_card?" do
    it "returns true if the card is a J, Q, or K" do
      expect(face_card.face_card?).to eq(true)
    end

    it "returns false if the card is not a J, Q, or K" do
      expect(two_diamond_card.face_card?).to eq(false)
    end
  end
end
