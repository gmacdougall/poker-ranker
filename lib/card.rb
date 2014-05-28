class Card
  include Comparable

  VALID_NUMBER_VALUES = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]
  VALID_SUIT_VALUES = {
    "C" => :clubs,
    "D" => :diamonds,
    "H" => :hearts,
    "S" => :spades
  }

  attr_reader :number
  attr_reader :suit

  def initialize(number, suit)
    @number = number
    @suit = suit
    raise "Invalid Card #{number} #{suit}" unless valid?
  end

  def self.parse(card_string)
    number = card_string.chars.first
    suit = VALID_SUIT_VALUES[card_string.chars.last.upcase]

    self.new number, suit
  end

  def <=>(c)
    number_index <=> number_index(c.number)
  end

  def ===(c)
    self.number == c.number && self.suit == c.suit
  end

  def next
    index = number_index + 1
    index = 0 if index == VALID_NUMBER_VALUES.size
    Card.new VALID_NUMBER_VALUES[index], @suit
  end

  def prev
    Card.new VALID_NUMBER_VALUES[number_index - 1], @suit
  end

  def self.rank(n)
    Card::VALID_NUMBER_VALUES.index(n)
  end

  def to_s
    @number + symbol
  end

  def inspect
    to_s
  end

  private
  def number_index(n = number)
    Card::rank(n)
  end

  def valid?
    VALID_NUMBER_VALUES.include?(@number) && VALID_SUIT_VALUES.values.include?(@suit)
  end

  def symbol
    case @suit
    when :spades
      "♠"
    when :diamonds
      "♦"
    when :clubs
      "♣"
    when :hearts
      "♥"
    end
  end
end
