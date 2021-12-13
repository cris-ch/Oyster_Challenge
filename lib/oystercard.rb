class Oystercard 
  MAXIMUM_BALANCE = 90
  DEFAULT_CAPACITY = 0

  attr_reader :balance, :travelling

  def initialize
    @balance = 0
    @travelling = false
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    fail "Insufficient funds" if balance - amount < 0
    @balance -= amount
  end

  def in_journey?
    @travelling
  end

  def touch_in
    @travelling = true
  end

  def touch_out
    @travelling = false
  end

end