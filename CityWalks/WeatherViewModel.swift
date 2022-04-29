//
//  WeatherViewModel.swift
//  CityWalks
//
//  Created by Josh Hart on 18/03/2022.
//

/*
import Foundation

private let defaultIcon = ""
private let iconImage = [
    "Drizzle" : "🌦",
    "Thurderstorm" : "🌩",
    "Rain" : "🌧",
    "Snow" : "❄️",
    "Clear" : "☀️",
    "Clouds" : "⛅",

]

public class WeatherViewModel: ObservableObject {
    @Published var cityName: String = "CityName"
    @Published var temperature: String = "--"
    @Published var weatherDescription: String = "--"
    @Published var weatherIcon: String = defaultIcon
    
    public let weatherService: WeatherService
    
    public init (weatherService: WeatherService){
        self.weatherService = weatherService
    }
    
    public func refresh() {
        weatherService.getUserLocation { weather in DispatchQueue.main.async {
            self.cityName = weather.city
            self.temperature = "\(weather.temperature)°C"
            self.weatherDescription = weather.description //.capitalized
            self.weatherIcon = iconImage[weather.iconName] ?? defaultIcon
        }}
    }
}

*/
