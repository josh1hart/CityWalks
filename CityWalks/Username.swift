//
//  Username.swift
//  CityWalks
//
//  Created by Josh Hart on 01/05/2022.
//

import SwiftUI
import UIKit
import HealthKit

/*
@MainActor class User: ObservableObject{
    @Published var name = "Test Username"
}
*/

struct Username: View {
    //@State public var username: String = ""
    
    //@StateObject var user = User()
    @EnvironmentObject var user: User
    @EnvironmentObject var testhealthStore: SampleObject
    
    @State private var isActive = false
    
    @State var show = false
    @State private var showNavView = false
    @State private var showModalView = false
    @ObservedObject var viewModel: WeatherViewModel
    @ObservedObject var stepviewModel: StepViewModel

    var body: some View {
        //@StateObject var testhealthStore = SampleObject()
        
            NavigationView{
                ZStack {
                    Color(red: 0.165, green: 0.165, blue: 0.165).edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("Welcome!")
                                        .font(.largeTitle)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.white)
                                        .padding(.bottom, 50)
                        VStack(alignment: .leading) {
                            Text("Username")
                                .font(.callout)
                                .foregroundColor(Color.white)
                                .bold()
                            TextField(
                                            "Enter username...",
                                            text: (self.$user.name),
                                            onEditingChanged: { (isBegin) in
                                                if isBegin {
                                                    print("Begins editing")
                                                } else {
                                                    print("Finishes editing")
                                                }
                                            },
                                            onCommit: {
                                                print("commit")
                                            }
                                        )
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            //TextField("Enter username...", text: $username)
                                //.textFieldStyle(RoundedBorderTextFieldStyle())
                        }.padding()
                        
                        if user.name.isEmpty {
                            ZStack {
                                Text("Enter")
                                    .foregroundColor(Color.gray)
                                    .padding(.top, 20.0)
                                Capsule()
                                    .stroke(LinearGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001)]), startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                    .frame(width: 60, height: 40)
                                    .padding(.top, 20.0)
                            }
                        } else {
                            NavigationLink(destination: CityWalks(viewModel: WeatherViewModel(weatherService: WeatherService()), stepviewModel: StepViewModel(healthStore: HealthStore()))) {
                                Text("Enter")
                                    .foregroundColor(Color.white)
                                    .padding(.all, 10.0)
                                    .foregroundColor(.white)
                                    .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001)]), startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round)))
                        }.padding(.top, 20.0)
                        
                                //.overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001), Color(red: 0.437, green: 0.911, blue: 1.001)]), startPoint: .leading, endPoint: .trailing)))
                        }
                        /*
                         Button(action: {
                             navigateTo = AnyView (PersonalWalks())
                             isActive = true
                         }, label: {
                             Label(
                                 title: { Text("PersonalWalks") },
                                 icon: { Image(systemName: "person") }
                             )
                         })
                         
                        Button(action: {
                            print($username)
                        }) {
                            Text("Enter")
                        }
                        */
                        
                        Image("StartScreen")
                                .resizable()
                                .frame(width: 100, height: 100)
                                //.scaledToFit()
                                .padding(.top, 200.0)
                        
                    }
                    .environmentObject(testhealthStore)
                   
                    /*
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
                    */
                     
                    .padding(.top, 5.0)
                    //.environmentObject(user)
                    .navigationBarColor(UIColor(Color(red: 0.483, green: 0.47, blue: 0.997)), textColor: .white)
                    .navigationBarTitle("Username")
                    .navigationBarHidden(true)
                    
                }//.environmentObject(user)
            }
    }
}

struct Username_Previews: PreviewProvider {
    static var previews: some View {
        Username(viewModel: WeatherViewModel(weatherService: WeatherService()), stepviewModel: StepViewModel(healthStore: HealthStore()))
    }
}
