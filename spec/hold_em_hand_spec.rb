require 'spec_helper'

describe HoldEmHand do
  let(:hand) { HoldEmHand.new(hole_cards, board) }
  let(:board) { HoldEmBoard.new board_cards }

  let(:hole_cards) { [Card.new('A', :spades), Card.new('K', :spades)] }
  let(:board_cards) { [
    Card.parse('2H'),
    Card.parse('6C'),
    Card.parse('TC'),
    Card.parse('JS'),
    Card.parse('AH'),
  ]}

  subject { hand  }

  describe '.cards' do
    subject { hand.cards }

    it 'has 2 hole cards' do
      expect(subject.size).to eq(2)
    end
  end

  describe '.valid' do
    context 'when all cards are unique' do
      it { should be_valid }
    end

    context 'when there are not two hole cards' do
      let(:hole_cards) { [Card.new('A', :spades)] }
      it { should_not be_valid }
    end

    context 'when both hole cards are the same' do
      let(:hole_cards) { [Card.new('A', :spades), Card.new('A', :spades)] }
      it { should_not be_valid }
    end

    context 'when both the hole cards and board share an identical card' do
      let(:hole_cards) { [Card.new('A', :hearts), Card.new('A', :spades)] }
      it { should_not be_valid }
    end

    context 'when the board is not valid' do
      let(:board_cards) { [Card.parse('2H')] }
      it { should_not be_valid }
    end
  end

  describe '.board' do
    subject { hand.board }

    it 'should be a HoldEmBoard' do
      expect(subject).to be_a(HoldEmBoard)
    end
  end

  describe '.all_cards' do
    subject { hand.all_cards }

    it 'has 7 cards in total' do
      expect(subject.size).to eq(7)
    end
  end

  describe '.best' do
    subject { hand.best }

    it 'returns the best hand from available cards' do
      expect(subject).to eq Hand.parse('AH AS KS JS TC')
    end
  end

  describe '#parse' do
    subject { HoldEmHand.parse "AS KS", board }

    it 'creates a new holdem hand' do
      expect(subject).to be_a HoldEmHand
    end

    it 'sets the cards from the string' do
      expect(subject.cards).to eq([Card.new('A', :spades), Card.new('K', :spades)])
    end

    it 'assigns the board' do
      expect(subject.board).to eq(board)
    end
  end

  describe 'comparison' do
    let(:left_hand_cards) { 'AS KH' }
    let(:right_hand_cards) { '2S 2C' }
    let(:left_hand) { HoldEmHand.parse left_hand_cards, board }
    let(:right_hand) { HoldEmHand.parse right_hand_cards, board }

    it 'prefers the better hand' do
      expect(left_hand).to be < right_hand
    end

    context 'when the hands are tied' do
      let(:left_hand_cards) { 'AS 3H' }
      let(:right_hand_cards) { 'AC 4C' }

      it 'shows the hands as tied' do
        expect(left_hand).to be == right_hand
      end
    end
  end
end
