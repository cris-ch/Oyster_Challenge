require 'journey'

describe Journey do
  let(:journey) { described_class.new }

  let(:station) { double("station") }
  let(:station) { double("station") }

  it "logs entry station" do
    journey.entry_station("Blackheath")
    expect(journey.stations).to eq ({in: "Blackheath", out: nil})
  end

  it "logs exit station" do
    journey.exit_station("Killburn")
    expect(journey.stations).to eq ({in: nil, out: "Killburn"})
  end

  it "charges penalty fare if journey incomplete" do
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  it "charges minimum fare if journey complete" do
    journey.entry_station("Blackheath")
    journey.exit_station("Killburn")
    expect(journey.fare).to eq Journey::MINIMUM_FARE
  end

  it 'saves station to journeys' do 
    journey.entry_station(station)
    expect(journey.stations).to eq ({in: station, out: nil})
  end

  it 'saves station to journeys' do 
    journey.exit_station(station)
    expect(journey.stations).to eq ({in: nil, out: station})
  end
end
