class HoldEmHand
  include Comparable

  attr_reader :cards
  attr_reader :board

  def initialize(cards, board)
    @cards = cards
    @board = board
  end

  def valid?
    @cards.size == 2 && all_cards.size == all_cards.uniq {|c| [c.number, c.suit] }.size && @board.is_a?(HoldEmBoard) && @board.valid?
  end

  def all_cards
    @cards + @board.cards
  end

  def best
    all_cards.combination(5).map { |cards| Hand.new cards }.max
  end

  def self.parse card_string, board
    new card_string.split(' ').map { |c| Card.parse c }, board
  end

  def <=>(h)
    best <=> h.best
  end

  def to_s
    "(#{@cards.map(&:to_s).join(' ')})"
  end

  def inspect
    to_s
  end
end
