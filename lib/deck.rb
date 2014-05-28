class Deck
  attr_reader :cards

  def initialize
    @cards = Card::VALID_NUMBER_VALUES.map do |num|
      Card::VALID_SUIT_VALUES.values.map do |suit|
        Card.new num, suit
      end
    end.flatten
    @cards.shuffle!
  end

  def deal
    hand = Hand.new @cards.pop(5)
    raise "Out of cards" unless hand.valid?
    hand
  end
end
