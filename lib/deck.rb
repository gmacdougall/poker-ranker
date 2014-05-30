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

  def deal(num_cards = 5)
    hand = Hand.new @cards.pop(num_cards)
    raise "Out of cards" if @cards.empty?
    hand
  end
end
