class Journey

  attr_reader :stations
  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize
    @stations = {in: nil, out: nil}
  end

  def entry_station(station)
    @stations[:in] = station
  end

  def exit_station(station)
    @stations[:out] = station
  end
  
  def fare
    return PENALTY_FARE unless @stations[:in] && @stations[:out]
    return MINIMUM_FARE if @stations[:in] != nil && @stations[:out] != nil
  end

end