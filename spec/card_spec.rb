require 'spec_helper'

describe Card do
  let(:card) { Card.new '8', :spades }
  subject { card }

  describe '.number' do
    subject { card.number }
    it { should == '8' }
  end

  describe 'valid cards' do
    context 'when the number is not correct' do
      let(:card) { Card.new '1', :spades }
      it 'raises an error' do
        expect{card}.to raise_error
      end
    end

    context 'when the suit is not correct' do
      let(:card) { Card.new '8', :flowers }
      it 'raises an error' do
        expect{card}.to raise_error
      end
    end
  end

  describe '.parse' do
    let(:card) { Card.parse '7D' }

    it 'sets the number' do
      expect(subject.number).to eq('7')
    end

    it 'sets the suit' do
      expect(subject.suit).to eq(:diamonds)
    end
  end

  describe '.suit' do
    subject { card.suit }

    describe 'spades' do
      it { should == :spades }
    end

    describe 'hearts' do
      let(:card) { Card.new '8', :hearts }
      it { should == :hearts }
    end

    describe 'clubs' do
      let(:card) { Card.new '8', :clubs }
      it { should == :clubs }
    end

    describe 'diamonds' do
      let(:card) { Card.new '8', :diamonds }
      it { should == :diamonds }
    end
  end

  describe '==' do
    subject { left_card == right_card }
    let(:left_card) { Card.new '8', :spades }

    context 'when the number matches' do
      let(:right_card) { Card.new '8', :diamonds }
      it { should be true }
    end

    context 'when the number does not match' do
      let(:right_card) { Card.new '9', :diamonds }
      it { should be false }
    end
  end

  describe '===' do
    subject { left_card === right_card }
    let(:left_card) { Card.new '8', :spades }

    context 'when the suit does not match' do
      let(:right_card) { Card.new '8', :diamonds }
      it { should be false }
    end

    context 'when the number does not match' do
      let(:right_card) { Card.new '9', :spades }
      it { should be false }
    end

    context 'when the both number does not match' do
      let(:right_card) { Card.new '8', :spades }
      it { should be true }
    end
  end

  describe '<' do
    subject { left_card < right_card }
    let(:left_card) { Card.new '8', :spades }

    context 'when the cards are equal' do
      let(:right_card) { Card.new '8', :diamonds }
      it { should be false }
    end

    context 'when the right card is greater' do
      let(:right_card) { Card.new 'T', :diamonds }
      it { should be true }
    end

    context 'when the left card is greater' do
      let(:right_card) { Card.new '6', :diamonds }
      it { should be false }
    end
  end

  describe '.next' do
    subject { card.next }
    context 'when the card is an ace' do
      let(:card) { Card.new 'A', :diamonds }

      it 'returns a two' do
        expect(subject.number).to eq('2')
      end
    end

    context 'when the card is not an ace' do
      it 'has a number of the next in order' do
        expect(subject.number).to eq('9')
      end
    end

    it 'is the same suit' do
      expect(subject.suit).to eq(:spades)
    end
  end

  describe '.prev' do
    subject { card.prev }
    context 'when the card is an two' do
      let(:card) { Card.new '2', :diamonds }

      it 'returns an ace' do
        expect(subject.number).to eq('A')
      end
    end

    context 'when the card is not a two' do
      it 'has a number of the previous in order' do
        expect(subject.number).to eq('7')
      end
    end

    it 'is the same suit' do
      expect(subject.suit).to eq(:spades)
    end
  end

  describe '#rank' do
    subject { Card.rank(rank) }

    context 'when it is a valid card number' do
      let(:rank) { 'T' }
      it { should == 8 }
    end

    context 'when it is not a valid card number' do
      let(:rank) { '1' }
      it { should be_nil }
    end
  end

  describe '.to_s' do
    subject { Card.new('8', suit).to_s }

    describe 'hearts' do
      let(:suit) { :hearts }
      it { should == "8♥" }
    end

    describe 'spades' do
      let(:suit) { :spades }
      it { should == "8♠" }
    end

    describe 'clubs' do
      let(:suit) { :clubs }
      it { should == "8♣" }
    end

    describe 'diamonds' do
      let(:suit) { :diamonds }
      it { should == "8♦" }
    end
  end

  describe '.inspect' do
    subject { Card.new('8', :spades).inspect }
    it 'returns the to_s' do
      expect(subject).to eq "8♠"
    end
  end
end
