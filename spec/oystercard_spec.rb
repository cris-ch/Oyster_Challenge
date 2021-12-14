# in spec/oystercard_spec.rb

require 'oystercard.rb'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  describe "#balance" do

    it { is_expected.to respond_to(:balance) }
    
    it 'has a default balance of 0' do
      expect(oystercard.balance).to eq(Oystercard::DEFAULT_CAPACITY)
    end
  
  end  
    
  describe "#top_up" do

    it 'can add money' do
      expect(oystercard.top_up(10)).to eq 10
    end

  end

  context 'top up limit is reached' do

    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      oystercard.top_up maximum_balance
      expect{ subject.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  
  end

  describe "#in_journey?" do
    it { is_expected.to respond_to(:in_journey?) }

    it "returns if card is in journey" do
      oystercard.top_up(10)
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end
  end

  describe "#touch_in" do
    it { is_expected.to respond_to(:touch_in) }

    it "returns if card touched in" do
      oystercard.top_up(10)
      expect(oystercard.touch_in).to eq true
    end

    it "returns 'Not enough money'" do
      expect { oystercard.touch_in }.to raise_error "Not enough money"
    end
  end

  describe "#touch_out" do
    it { is_expected.to respond_to(:touch_out) }

    it "returns if card touched in" do
      oystercard.top_up(10)
      oystercard.touch_out
      expect(oystercard.in_journey?).to eq false
    end

    it "deducts the minimum fare" do 
      oystercard.top_up(10)
      expect { oystercard.touch_out }.to change{ oystercard.balance }.by(-Oystercard::DEFAULT_MINIMUM)
    end
  end

  

end