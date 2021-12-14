require 'journey'

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
    @journey != nil

  end

  def touch_in(station)
    fail "Not enough money" if balance < DEFAULT_MINIMUM
    if in_journey? 
      deduct
    else
      @journey = Journey.new
      @journey.entry_station(station)
    end
    
  end

  def touch_out(station)
    if in_journey?
      @journey.exit_station(station) 
    else
      @journey = Journey.new
      @journey.exit_station(station)
    end
    deduct
    @journey = nil
  end

  private

  def deduct
    # fail "Insufficient funds" if balance - amount < 0
    @balance -= @journey.fare
  end
end