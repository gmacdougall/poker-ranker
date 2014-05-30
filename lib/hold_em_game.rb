require 'game'

class HoldEmGame < Game
  attr_reader :board

  def initialize(num_players)
    deck = Deck.new
    hole_cards = num_players.times.map { deck.deal(2).cards }
    board_cards = deck.deal.cards

    @board = HoldEmBoard.new(board_cards)

    @hands = hole_cards.map { |h| HoldEmHand.new h, @board}
  end

  def to_s
    @hands.map(&:to_s).join('  ') + "\nBoard: " + Hand.new(@board.cards).to_s
  end

  def inspect
    to_s
  end
end
