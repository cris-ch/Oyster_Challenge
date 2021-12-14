class Oystercard 
  MAXIMUM_BALANCE = 90
  DEFAULT_CAPACITY = 0
  DEFAULT_MINIMUM = 1

  attr_reader :balance, :travelling

  def initialize
    @balance = 0
    @travelling = false
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @travelling
  end

  def touch_in
    fail "Not enough money" if balance < DEFAULT_MINIMUM
    @travelling = true
  end

  def touch_out
    deduct(DEFAULT_MINIMUM)
    @travelling = false
  end

  private

  def deduct(amount)
    fail "Insufficient funds" if balance - amount < 0
    @balance -= amount
  end
end