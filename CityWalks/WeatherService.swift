//
//  WeatherService.swift
//  CityWalks
//
//  Created by Josh Hart on 18/03/2022.
//

import Foundation
import CoreLocation

public final class WeatherService: NSObject, CLLocationManagerDelegate {
    public override init(){
        super.init()
        locationManager.delegate = self
    }
    private let locationManager = CLLocationManager()
    private let API_KEY = "ae44fbddb3cd1329b8b9b5ac221b08a7"
    private var completionHandler: ((Weather) -> Void)?
    
    public func getUserLocation (_ completionHandler: @escaping((Weather) -> Void)) {
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    public func locationManager (_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        makeDataRequest(forCoordinates: location.coordinate)
    }
    
    public func locationManager (_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Issue with data: \(error.localizedDescription)")
    }
    
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
        guard let urlString =
            "https://api.openweathermap.org/data/2.5/weather?lat=36.595104&lon=-82.188744&appid=ae44fbddb3cd1329b8b9b5ac221b08a7&units=metric"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else { return }
        
        guard let url = URL(string: urlString) else { return }
    
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard error == nil, let data = data else { return }
            
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                self.completionHandler?(Weather(response: response))
            }
        }.resume()
    }
}

struct APIResponse: Decodable {
    let name: String
    let main: APIMain
    let weather: [APIWeather]
}

struct APIMain: Decodable {
    let temp: Double
}

struct APIWeather: Decodable{
    let description: String
    let iconName: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    }
}
