require './lib/oystercard'

oystercard = Oystercard.new

# p oystercard.balance
# p oystercard.top_up(10)


oystercard.top_up(10)
oystercard.touch_in("st1")
oystercard.touch_out("st2")
oystercard.touch_in("st3")
oystercard.touch_out("st4")



expect(oystercard.journeys).to eq [{st1: :st2}, {st3: :st4}]

