# in spec/oystercard_spec.rb

require 'oystercard.rb'

describe Oystercard do
  
  def topup_touchin
    oystercard.top_up(10)
    oystercard.touch_in(station)
  end

  def topup_touchin_touchout
    oystercard.top_up(10)
    oystercard.touch_in(station)
    oystercard.touch_out(station2)
  end
  
  let(:station) { double("station") }
  let(:station2) { double("station") }

  subject(:oystercard) { described_class.new }

  describe "#balance" do
    
    it 'has a default balance of 0' do
      expect(oystercard.balance).to eq(Oystercard::DEFAULT_CAPACITY)
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

    it "returns if card is in journey" do
      topup_touchin
      expect(oystercard).to be_in_journey
    end
  end

  describe "#touch_in" do

    it "returns 'Not enough money'" do
      expect { oystercard.touch_in(station) }.to raise_error "Not enough money"
    end

    it 'records the entry station' do
      oystercard.top_up(10)
      expect(oystercard.touch_in(station)).to eq station
    end

    it 'saves station to journeys' do 
      topup_touchin
      expect(oystercard.journeys).to eq [{in: station, out: nil}]
    end
  end

  describe "#touch_out" do

    it "returns if card touched in" do
      topup_touchin_touchout
      expect(oystercard.in_journey?).to eq false
    end

    it "deducts the minimum fare" do 
      topup_touchin
      expect { oystercard.touch_out(station) }.to change{ oystercard.balance }.by(-Oystercard::DEFAULT_MINIMUM)
    end

    it 'sets entry_station to nil' do
      topup_touchin_touchout
      expect(oystercard.entry_station).to eq nil
    end

    it 'saves station to journeys' do 
      topup_touchin_touchout
      expect(oystercard.journeys).to eq [{in: station, out: station2}]
    end
  end
end