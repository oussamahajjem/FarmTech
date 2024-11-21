import Foundation

struct WeatherDto: Codable {
    let summary: SummaryDto
    let forecasts: [ForecastDto]
}

struct SummaryDto: Codable {
    let startDate: String
    let severity: Int
    let phrase: String
    let category: String
}

struct ForecastDto: Codable {
    let date: String
    let temperature: TemperatureRangeDto
    let realFeelTemperature: TemperatureRangeDto
    let realFeelTemperatureShade: TemperatureRangeDto
    let hoursOfSun: Double
    let degreeDaySummary: DegreeDaySummaryDto
    let airAndPollen: [AirAndPollenDto]
    let day: PeriodDto
    let night: PeriodDto
    let sources: [String]
}

struct TemperatureRangeDto: Codable {
    let minimum: TemperatureDto
    let maximum: TemperatureDto
}

struct TemperatureDto: Codable {
    let value: Double
    let unit: String
    let unitType: Int
}

struct DegreeDaySummaryDto: Codable {
    let heating: TemperatureDto
    let cooling: TemperatureDto
}

struct AirAndPollenDto: Codable {
    let name: String
    let value: Int
    let category: String
    let categoryValue: Int
    let type: String?
}

struct PeriodDto: Codable {
    let iconCode: Int
    let iconPhrase: String
    let hasPrecipitation: Bool
    let precipitationType: String?
    let precipitationIntensity: String?
    let shortPhrase: String
    let longPhrase: String
    let precipitationProbability: Int
    let thunderstormProbability: Int
    let rainProbability: Int
    let snowProbability: Int
    let iceProbability: Int
    let wind: WindDto
    let windGust: WindDto
    let totalLiquid: PrecipitationDto
    let rain: PrecipitationDto
    let snow: PrecipitationDto
    let ice: PrecipitationDto
    let hoursOfPrecipitation: Double
    let hoursOfRain: Double
    let hoursOfSnow: Double
    let hoursOfIce: Double
    let cloudCover: Int
}

struct WindDto: Codable {
    let direction: DirectionDto
    let speed: SpeedDto
}

struct DirectionDto: Codable {
    let degrees: Int
    let localizedDescription: String
}

struct SpeedDto: Codable {
    let value: Double
    let unit: String
    let unitType: Int
}

struct PrecipitationDto: Codable {
    let value: Double
    let unit: String
    let unitType: Int
}

