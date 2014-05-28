require 'spec_helper'

describe Game do
  describe 'initialize' do
    it 'supports up to 10 players' do
      expect{Game.new(10)}.to_not raise_error
    end

    it 'raises an error when attempting to use 11 players' do
      expect{Game.new(11)}.to raise_error
    end
  end

  describe '.hands' do
    subject { Game.new(5).hands }
    it 'has a hand for every player' do
      expect(subject.size).to eq(5)
    end
  end

  describe '.winner' do
    let(:hand_one) { Hand.parse("AS KS QS JS TS") }
    let(:hand_two) { Hand.parse("2S 6H 9D 8C 8D")}
    let(:hand_three) { Hand.parse("3H QD QH QC KD") }

    before do
      allow_any_instance_of(Deck).to receive(:deal).and_return(hand_one, hand_two, hand_three)
    end
    subject { Game.new(3).winner }

    context 'when there is a clear winner' do
      it 'picks the best hand' do
        expect(subject).to eq [hand_one]
      end
    end

    context 'when there is a tie' do
      let(:hand_three) { Hand.parse("AD KD QD JD TD") }
      it 'returns all tied hands' do
        expect(subject).to eq [hand_one, hand_three]
      end
    end
  end
end

