class Game
  attr_reader :hands

  def initialize(num_players)
    deck = Deck.new
    @hands = num_players.times.map { deck.deal }
  end

  def winner
    @hands.select { |hand| hand == @hands.max }
  end
end
