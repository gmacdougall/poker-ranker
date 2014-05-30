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

    context 'when dealing 5 cards' do
      it 'is a valid hand' do
        expect(subject).to be_valid
      end

      describe 'after dealing' do
        it 'contains 47 cards' do
          subject
          expect(deck.cards.size).to eq(47)
        end
      end
    end

    context 'when dealing 2 cards' do
      subject { deck.deal 2 }

      it 'is returns a hand containing 2 cards' do
        expect(subject.cards.size).to eq 2
      end

      describe 'after dealing' do
        it 'contains 50 cards' do
          subject
          expect(deck.cards.size).to eq(50)
        end
      end
    end

    it 'gives me a hand' do
      expect(subject).to be_a(Hand)
    end

    describe 'dealing until the cards run out' do
      it 'raises an error' do
        10.times { deck.deal }
        expect{deck.deal}.to raise_error
      end
    end
  end
end
