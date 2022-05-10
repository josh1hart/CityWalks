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

//Global Var's
//Username
@MainActor class User: ObservableObject{
    @Published var name = ""
}
//Users Steps
@MainActor class UStep: ObservableObject{
    @Published var usersteps = 7_367
}
//Users City Steps
@MainActor class CStep: ObservableObject{
    @Published var citysteps = 19_002_349
}

//global object for initializing health store
class SampleObject: ObservableObject {
    @Published var healthStore = HealthStore()
}

struct ContentView: View {
    
    //pedo start
    @StateObject var testhealthStore = SampleObject()

    public var healthStore: HealthStore?
    @State public var steps: [Step] = [Step]()
               
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
    
    //Stating the globalised var's
    @StateObject var user = User()
    @StateObject var usteps = UStep()
    @StateObject var csteps = CStep()
     
    @State var show = false
    @State private var showNavView = false
    @State private var showModalView = false
    @ObservedObject var viewModel: WeatherViewModel
    @ObservedObject var stepviewModel: StepViewModel
    
    @State private var navigateTo: AnyView?
    @State private var isActive = false
    
    //totalSteps caluclated from step array
    //This can be printed but currently cannot authrise healthkit
    var totalSteps: Int {
        steps.map { $0.count }.reduce(0,+)
    }

    //@StateObject var UserInfo = UserInfo()
    
    var body: some View {
        VStack {
            
            Username(viewModel: WeatherViewModel(weatherService: WeatherService()), stepviewModel: StepViewModel(healthStore: HealthStore()))
                .environmentObject(user)
                .environmentObject(usteps)
                .environmentObject(csteps)
                .environmentObject(testhealthStore)
            //pedo start, below can print total steps
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //this creates a step array allowing the preview show data without a similator
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
