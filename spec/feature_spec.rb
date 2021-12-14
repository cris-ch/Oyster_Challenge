require './lib/oystercard'

oystercard = Oystercard.new

p oystercard.balance
p oystercard.top_up(10)

oystercard.touch_in
oystercard.touch_out

