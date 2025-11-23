class Lasagna
  EXPECTED_MINUTES_IN_OVEN = 40
  PREP_MINUTES_PER_LAYER = 2
  def remaining_minutes_in_oven(actual_minutes_in_oven)
    # raise 'Please implement the Lasagna#remaining_minutes_in_oven method'
    EXPECTED_MINUTES_IN_OVEN - actual_minutes_in_oven
  end

  def preparation_time_in_minutes(layers)
    # raise 'Please implement the Lasagna#preparation_time_in_minutes method'
    layers * PREP_MINUTES_PER_LAYER
  end

  def total_time_in_minutes(number_of_layers:, actual_minutes_in_oven:)
    self.preparation_time_in_minutes(number_of_layers) + actual_minutes_in_oven    # raise 'Please implement the Lasagna#total_time_in_minutes method'
  end
end
