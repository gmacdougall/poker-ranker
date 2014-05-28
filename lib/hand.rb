class Hand
  include Comparable

  def initialize(cards)
    @cards = cards
  end

  attr_reader :cards

  def self.parse(card_string)
    Hand.new(card_string.split(' ').map { |cs| Card.parse(cs) })
  end

  def valid?
    @cards.size == 5 && @cards.size == @cards.uniq {|c| [c.number, c.suit]}.size
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    sets.size == 2 && sets.first.last == 4
  end

  def full_house?
    sets.size == 2 && sets.first.last == 3
  end

  def flush?
    @cards.all? { |card| card.suit == @cards.first.suit }
  end

  def straight?
    cards = @cards.sort
    (
      (0..2).all? { |n| cards[n].next == cards[n+1 ]} &&
      (cards[3].next == cards[4] || cards[4].next == cards[0])
    )
  end

  def three_of_a_kind?
    sets.size == 3 && sets.first.last == 3
  end

  def two_pair?
    sets.size == 3 && sets.first.last == 2
  end

  def one_pair?
    sets.size == 4
  end

  def rank
    if straight_flush?
      8
    elsif four_of_a_kind?
      7
    elsif full_house?
      6
    elsif flush?
      5
    elsif straight?
      4
    elsif three_of_a_kind?
      3
    elsif two_pair?
      2
    elsif one_pair?
      1
    else
      0
    end
  end

  def rank_string
    ["High Card", "One Pair", "Two Pair", "Three of a Kind", "Straight", "Flush", "Full House", "Four of a Kind", "Straight Flush"][rank]
  end

  def <=>(h)
    h_sets = h.send(:sets)
    [rank <=> h.rank, (0..4).map { |i| (sets[i] || []).first <=> (h_sets[i] || []).first }].flatten.compact.reject(&:zero?).first || 0
  end

  def inspect
    to_s
  end

  def to_s
    "(#{@cards.map(&:to_s).join(' ')})"
  end

  private
  def sets
    sets = Hash.new(0)
    @cards.each do |card|
      sets[Card.rank(card.number)] += 1
    end
    sets.sort { |a, b| [-a.last, -a.first] <=> [-b.last, -b.first] }
  end
end
