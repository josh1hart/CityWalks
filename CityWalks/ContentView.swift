//
//  ContentView.swift
//  CityWalks
//
//  Created by Josh Hart on 18/03/2022.
//
import SwiftUI
import UIKit
import SwiftUICharts
import HealthKit

//import CoreMotion
/*
let healthStore = HKHealthStore()

func getTodaysSteps(completion: @escaping (Double) -> Void) {
    let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
    
    let now = Date()
    let startOfDay = Calendar.current.startOfDay(for: now)
    let predicate = HKQuery.predicateForSamples(
        withStart: startOfDay,
        end: now,
        options: .strictStartDate
    )
    
    let query = HKStatisticsQuery(
        quantityType: stepsQuantityType,
        quantitySamplePredicate: predicate,
        options: .cumulativeSum
    ) { _, result, _ in
        guard let result = result, let sum = result.sumQuantity() else {
            completion(0.0)
            return
        }
        completion(sum.doubleValue(for: HKUnit.count()))
    }
    
    healthStore.execute(query)
}
*/
//let pedometer = CMPedometer()

@MainActor class User: ObservableObject{
    @Published var name = ""
}

@MainActor class UStep: ObservableObject{
    @Published var usersteps = 7_367
}

@MainActor class CStep: ObservableObject{
    @Published var citysteps = 19_002_349
}

struct ContentView: View {
    
    @StateObject var user = User()
    @StateObject var usteps = UStep()
    @StateObject var csteps = CStep()
    /*
    @ObservedObject var viewModel: WeatherViewModel
    public var PageName = "City"
    */
     
    @State var show = false
    @State private var showNavView = false
    @State private var showModalView = false
    @ObservedObject var viewModel: WeatherViewModel
    
    @State private var navigateTo: AnyView?
    @State private var isActive = false
    
    //Username Global Var
    
    //@StateObject var UserInfo = UserInfo()
    
    var body: some View {
        Username(viewModel: WeatherViewModel(weatherService: WeatherService()))
            .environmentObject(user)
            .environmentObject(usteps)
            .environmentObject(csteps)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}




/*
let navBar = self.navigationController!.navigationBar

let standardAppearance = UINavigationBarAppearance()
standardAppearance.configureWithOpaqueBackground()
standardAppearance.backgroundImage = backImageForDefaultBarMetrics

let compactAppearance = standardAppearance.copy()
compactAppearance.backgroundImage = backImageForLandscapePhoneBarMetrics

navBar.standardAppearance = standardAppearance
navBar.scrollEdgeAppearance = standardAppearance
navBar.compactAppearance = compactAppearance
*/

/*
public init(viewModel: WeatherViewModel) {
    let navBarAppearance = UINavigationBarAppearance()
    navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemBackground]
    navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBackground]
    navBarAppearance.backgroundColor = UIColor.gray
    navBarAppearance.shadowColor = .clear
    UINavigationBar.appearance().standardAppearance = navBarAppearance
    UINavigationBar.appearance().compactAppearance = navBarAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    UINavigationBar.appearance().tintColor = UIColor.systemBackground
    
    @ObservedObject var viewModel: WeatherViewModel
}
*/

/*
init(){
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(Color())]
}
*/
