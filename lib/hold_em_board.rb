class HoldEmBoard
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def valid?
    @cards.size == 5
  end
end
