require 'spec_helper'

describe Deck do
  let(:deck) { Deck.new }

  describe '.cards' do
    subject { deck.cards }
    it 'contains 52 cards' do
      expect(subject.size).to eq(52)
    end
  end

  describe '.deal' do
    subject { deck.deal }
    it 'gives me a hand' do
      expect(subject).to be_a(Hand)
    end

    it 'is a valid hand' do
      expect(subject).to be_valid
    end

    describe 'after dealing' do
      it 'contains 47 cards' do
        expect(deck.cards.size).to eq(52)
      end
    end

    describe 'dealing until the cards run out' do
      it 'raises an error' do
        10.times { deck.deal }
        expect{deck.deal}.to raise_error
      end
    end
  end
end
