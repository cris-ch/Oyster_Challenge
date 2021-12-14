require 'station'

describe Station do
  
  subject(:station) { described_class.new("Blackheath", 1) }
  
  it 'knows it name' do
    expect(station.name).to eq("Blackheath")
  end

  it 'knows its zone' do
    expect(station.zone).to eq(1)
  end

end