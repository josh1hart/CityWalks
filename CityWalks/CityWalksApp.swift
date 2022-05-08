//
//  CityWalksApp.swift
//  CityWalks
//
//  Created by Josh Hart on 18/03/2022.
//


import SwiftUI
import HealthKit

@main
struct CityWalksApp: App {
    var body: some Scene {
        WindowGroup {
            
            let weatherService = WeatherService()
            let viewModel = WeatherViewModel(weatherService: weatherService)
            
            
            let healthStore = HealthStore()
            let stepviewModel = StepViewModel(healthStore: healthStore)
            
            ContentView(viewModel: WeatherViewModel(weatherService: WeatherService()), stepviewModel: StepViewModel(healthStore: HealthStore()))
        }
    }
}
