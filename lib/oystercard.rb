class Oystercard 
  MAXIMUM_BALANCE = 90
  DEFAULT_CAPACITY = 0
  DEFAULT_MINIMUM = 1

  attr_reader :balance, :entry_station, :journeys

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    fail "Not enough money" if balance < DEFAULT_MINIMUM
    @journeys << {in: station, out: nil}
    @entry_station = station
  end

  def touch_out(station)
    deduct(DEFAULT_MINIMUM)
    @journeys[-1][:out] = station 
    @entry_station = nil
  end

  private

  def deduct(amount)
    fail "Insufficient funds" if balance - amount < 0
    @balance -= amount
  end
end