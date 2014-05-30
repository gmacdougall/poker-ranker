require 'spec_helper'

describe HoldEmBoard do
  subject { HoldEmBoard.new cards }
  let(:cards) do
    [
      Card.parse('AH'),
      Card.parse('KH'),
      Card.parse('QH'),
      Card.parse('JH'),
      Card.parse('TH'),
    ]
  end

  describe '.cards' do
    it 'returns an array of cards' do
      expect(subject.cards).to eq(cards)
    end
  end

  describe '.valid?' do
    context 'when it has 5 cards' do
      it { should be_valid }
    end

    context 'when it does not have 5 cards' do
      let(:cards) { [Card.parse('AH')] }

      it { should_not be_valid }
    end
  end
end
