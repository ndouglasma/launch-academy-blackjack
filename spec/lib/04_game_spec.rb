require "spec_helper"
require_relative "../../lib/deck"
require_relative "../../lib/game"

#03/18/18: In the interest of time, will not create more game test cases or blackjack.rb test cases
describe Game do
  let(:test_game) { Game.new }

  context "#initialize" do
    it "is a Game object" do
      expect(test_game).to be_a(Game)
    end

    it "Game has a card deck" do
      expect(test_game.card_deck).to be_a(Deck)
    end
  end
end
