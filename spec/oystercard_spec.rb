# in spec/oystercard_spec.rb

# In order to use public transport
# As a customer
# I want money on my card

require 'oystercard.rb'

describe OysterCard do
  subject(:oystercard) { described_class.new }

  describe "#balance" do

    it { is_expected.to respond_to(:balance) }
    
    it 'has a balance of 0' do
      expect(oystercard.balance).to eq(OysterCard::DEFAULT_CAPACITY)
    end

  end

end