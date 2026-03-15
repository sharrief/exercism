/* Package weather provides a utility for forecasting the weather. */
package weather

var (
	// CurrentCondition specifies the weather at the CurrentLocation.
	CurrentCondition string
	// CurrentLocation specifies the location with the weather refered to by CurrentCondition.
	CurrentLocation  string
)
// Forecast accepts a city and condition and returns a formatted weather forecast.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
