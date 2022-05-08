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

class SampleObject: ObservableObject {
    @Published var healthStore = HealthStore()
}

struct ContentView: View {
    
    //pedo start
    
    @StateObject var testhealthStore = SampleObject()
    
    
    public var healthStore: HealthStore?
    @State public var steps: [Step] = [Step]()
    
    
    /*
    public init() {
        healthStore = HealthStore()
    }
    */
               
    
    public func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
        }
        
    }
    
    //pedd end
    
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
    @ObservedObject var stepviewModel: StepViewModel
    //@ObservedObject var stepviewModel: StepViewModel
    
    @State private var navigateTo: AnyView?
    @State private var isActive = false
    
    
    var totalSteps: Int {
        steps.map { $0.count }.reduce(0,+)
    }
    //Username Global Var
    
    
    //@StateObject var UserInfo = UserInfo()
    
    var body: some View {
        VStack {
            
            Username(viewModel: WeatherViewModel(weatherService: WeatherService()), stepviewModel: StepViewModel(healthStore: HealthStore()))
            //Text("Total Steps: \(totalSteps)").padding()
                .environmentObject(user)
                .environmentObject(usteps)
                .environmentObject(csteps)
                .environmentObject(testhealthStore)
            //pedo start
            //Text("Test: \(testhealthStore.healthStore)")
            //Text("Total Steps: \(totalSteps)")//.padding()
                
        }
        .onAppear {
            if let healthStore = healthStore {
                healthStore.requestAuthorization { success in
                    if success {
                        healthStore.calculateSteps { statisticsCollection in
                            if let statisticsCollection = statisticsCollection {
                                // update the UI
                                updateUIFromStatistics(statisticsCollection)
                            }
                        }
                    }
                }
            }
        }
        
        
        //pedo end
        
        /*
            .onAppear{
                if let healthStore = healthStore {
                    healthStore.requestAuthorization{ success in
                        
                    }
                }
            }
         */
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let steps = [
                   Step(count: 3452, date: Date()),
                   Step(count: 123, date: Date()),
                   Step(count: 1223, date: Date()),
                   Step(count: 5223, date: Date()),
                   Step(count: 12023, date: Date())
               ]
        ContentView(steps: steps, viewModel: WeatherViewModel(weatherService: WeatherService()), stepviewModel: StepViewModel(healthStore: HealthStore()))
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
