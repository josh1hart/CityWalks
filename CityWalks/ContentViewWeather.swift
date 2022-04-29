//
//  ContentViewWeather.swift
//  CityWalks
//
//  Created by Josh Hart on 29/04/2022.
//

import SwiftUI

struct ContentViewWeather: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack{
            Text(viewModel.cityName)
                .padding()
            Text(viewModel.temperature)
                .padding()
            Text(viewModel.weatherIcon)
                .padding()
            Text(viewModel.weatherDescription)
                .padding()
        }.onAppear(perform: viewModel.refresh)
    }
}


struct ContentViewWeather_Previews: PreviewProvider {
static var previews: some View {
    ContentViewWeather(viewModel: WeatherViewModel(weatherService: WeatherService()))
}
}

