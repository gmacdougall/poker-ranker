require 'spec_helper'

describe Hand do
  let(:hand) { Hand.parse cards }
  subject { hand }

  let(:straight_flush) { '4S 5S 6S 7S 8S' }
  let(:four_of_a_kind) { '4S 4H 4C 4D 8S' }
  let(:full_house) { '4S 4H 4C 8D 8S' }
  let(:flush) { '4S 6S 8S QS KS' }
  let(:straight) { '4S 5D 6C 7D 8D' }
  let(:three_of_a_kind) { '6S 6D 6C 5D 9H' }
  let(:two_pair) { '3S 3D 5C 5D 9H' }
  let(:one_pair) { '4S 4H 8C 9D QH' }
  let(:high_card) { 'AS 4H 8C 9D QH' }

  describe '.valid?' do
    context 'when it has 5 cards' do
      context 'when all cards are unique' do
        let(:cards) { 'AS 2S 3S 4S 5S' }
        it { should be_valid }
      end

      context 'when the hand contains duplicate cards' do
        let(:cards) { 'AS AS 3S 4S 5S' }
        it { should_not be_valid }
      end

      context 'when the hand contains invalid cards' do
        let(:cards) { 'RR AS 3S 4S 5S' }
        it 'raises an error' do
          expect{subject}.to raise_error
        end
      end
    end

    context 'when it does not have 5 cards' do
        let(:cards) { 'AS 3S 4S 5S' }
      it { should_not be_valid }
    end
  end

  describe '.straight_flush?' do
    context 'when all my cards are of the same suit and consecutive' do
      let(:cards) { straight_flush }
      it { should be_a_straight_flush }
    end

    context 'when all my cards are not consecutive' do
      let(:cards) { flush }
      it { should_not be_a_straight_flush }
    end

    context 'when all my cards are not in the same suit' do
      let(:cards) { straight }
      it { should_not be_a_straight_flush }
    end
  end

  describe '.four_of_a_kind?' do
    context 'when there are four of the same number' do
      let(:cards) { four_of_a_kind }
      it { should be_four_of_a_kind }
    end

    context 'when there are not four of the same number' do
      let(:cards) { two_pair }
      it { should_not be_four_of_a_kind }
    end
  end

  describe '.full_house?' do
    context 'when there are three of one number, and two of another' do
      let(:cards) { full_house }
      it { should be_a_full_house }
    end

    context 'whern there are not three of one number, and two of another' do
      let(:cards) { two_pair }
      it { should_not be_a_full_house }
    end
  end

  describe '.straight?' do
    context 'when all cards are consecutive' do
      let(:cards) { straight }
      it { should be_a_straight }

      describe 'wrap-around straight' do
        let(:cards) { 'AS 2S 3S 4S 5D' }
        it { should be_a_straight }
      end
    end

    context 'when all cards are not consecutive' do
      let(:cards) { two_pair }
      it { should_not be_a_straight }
    end
  end

  describe '.flush?' do
    context 'when all cards are the same suit' do
      let(:cards) { flush }
      it { should be_a_flush }
    end

    context 'when all cards are not the same suit' do
      let(:cards) { two_pair }
      it { should_not be_a_flush }
    end
  end

  describe '.three_of_a_kind?' do
    context 'when there are three of one card' do
      let(:cards) { three_of_a_kind }
      it { should be_three_of_a_kind }
    end

    context 'when there are not three of one card' do
      let(:cards) { one_pair }
      it { should_not be_three_of_a_kind }
    end
  end

  describe '.two_pair?' do
    context 'when there two of the same card twice' do
      let(:cards) { two_pair }
      it { should be_two_pair }
    end

    context 'when there are not two of the same card twice' do
      let(:cards) { one_pair }
      it { should_not be_two_pair }
    end
  end

  describe '.one_pair?' do
    context 'when there are two of the same card' do
      let(:cards) { one_pair }
      it { should be_one_pair }
    end

    context 'when there are not two of the same card twice' do
      let(:cards) { high_card }
      it { should_not be_one_pair }
    end
  end

  describe '.rank' do
    subject { hand.rank }

    describe 'straight flush' do
      let(:cards) { straight_flush }
      it { should == 8 }
    end

    describe 'four of a kind' do
      let(:cards) { four_of_a_kind }
      it { should == 7 }
    end

    describe 'full house' do
      let(:cards) { full_house }
      it { should == 6 }
    end

    describe 'flush' do
      let(:cards) { flush }
      it { should == 5 }
    end

    describe 'straight' do
      let(:cards) { straight }
      it { should == 4 }
    end

    describe 'three of a kind' do
      let(:cards) { three_of_a_kind }
      it { should == 3 }
    end

    describe 'two pair' do
      let(:cards) { two_pair }
      it { should == 2 }
    end

    describe 'one pair' do
      let(:cards) { one_pair }
      it { should == 1 }
    end

    describe 'high card' do
      let(:cards) { high_card }
      it { should == 0 }
    end
  end

  describe '.rank_string' do
    subject { hand.rank_string }

    describe 'straight flush' do
      let(:cards) { straight_flush }
      it { should == "Straight Flush" }
    end

    describe 'four of a kind' do
      let(:cards) { four_of_a_kind }
      it { should == "Four of a Kind" }
    end

    describe 'full house' do
      let(:cards) { full_house }
      it { should == "Full House" }
    end

    describe 'flush' do
      let(:cards) { flush }
      it { should == "Flush" }
    end

    describe 'straight' do
      let(:cards) { straight }
      it { should == "Straight" }
    end

    describe 'three of a kind' do
      let(:cards) { three_of_a_kind }
      it { should == "Three of a Kind" }
    end

    describe 'two pair' do
      let(:cards) { two_pair }
      it { should == "Two Pair" }
    end

    describe 'one pair' do
      let(:cards) { one_pair }
      it { should == "One Pair" }
    end

    describe 'high card' do
      let(:cards) { high_card }
      it { should == "High Card" }
    end
  end

  describe 'comparison' do
    let(:left_hand) { Hand.parse left_hand_cards }
    let(:right_hand) { Hand.parse right_hand_cards }

    describe 'higher rank hands beat lower ranked hands' do
      let(:left_hand_cards) { four_of_a_kind }
      let(:right_hand_cards) { straight }

      it 'shows the higher ranked hand being greater' do
        expect(left_hand).to be > right_hand
      end
    end

    describe 'same ranked hands, but higher sets' do
      describe 'full house' do
        let(:left_hand_cards) { 'AH AS AC 4S 4S'}
        let(:right_hand_cards) { 'KH KS KC QS QS'}

        it 'favours the hand with the better three of a kind' do
          expect(left_hand).to be > right_hand
        end
      end

      describe 'two pair' do
        context 'when the higher pair is not tied' do
          let(:left_hand_cards) { 'AH AS 7C 4S 4S'}
          let(:right_hand_cards) { 'KH KS JC QS QS'}

          it 'favours the hand with higher top pair' do
            expect(left_hand).to be > right_hand
          end
        end

        context 'when the higher pair is tied' do
          let(:left_hand_cards) { 'AH AS 7C 4S 4C'}
          let(:right_hand_cards) { 'AH AS JC QS QC'}

          it 'favours the hand with higher top pair' do
            expect(left_hand).to be < right_hand
          end
        end

        context 'when both pairs are tied' do
          let(:left_hand_cards) { 'AH AS 7C QD QD'}
          let(:right_hand_cards) { 'AH AS JC QS QC'}

          it 'favours the hand with higher kicker' do
            expect(left_hand).to be < right_hand
          end
        end
      end
    end

    describe 'high card' do
      let(:left_hand_cards) { 'AH KS QC JC 7C'}
      let(:right_hand_cards) { 'AC KD QS JS 6S'}

      it 'favours the hand with higher card after all tiebreakers' do
        expect(left_hand).to be > right_hand
      end
    end

    describe 'identical hands' do
      let(:left_hand_cards) { 'AH AS 2C 3C 4C'}
      let(:right_hand_cards) { 'AC AD 2S 3S 4S'}

      it 'ranks the hands equally' do
        expect(left_hand).to be == right_hand
      end
    end
  end

  describe '.to_s' do
    let(:cards) { straight_flush }

    it 'renders the cards fancily' do
      expect(subject.to_s).to eq "(4♠ 5♠ 6♠ 7♠ 8♠)"
    end
  end

  describe '.inspect' do
    let(:cards) { straight_flush }

    it 'renders the to_s' do
      expect(subject.inspect).to eq "(4♠ 5♠ 6♠ 7♠ 8♠)"
    end
  end
end
