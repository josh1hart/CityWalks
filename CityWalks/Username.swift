//
//  Username.swift
//  CityWalks
//
//  Created by Josh Hart on 01/05/2022.
//

import SwiftUI
import UIKit

/*
@MainActor class User: ObservableObject {
    @Published var name = "Test"
}
*/

struct Username: View {
    @State public var username: String = ""
    @State private var isActive = false
    
    @State var show = false
    @State private var showNavView = false
    @State private var showModalView = false
    @ObservedObject var viewModel: WeatherViewModel

    //@EnvironmentObject var user: User

    var body: some View {
            NavigationView{
                ZStack {
                    Color(red: 0.165, green: 0.165, blue: 0.165).edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("Welcome!")
                                        .font(.largeTitle)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.white)
                                        .padding(.bottom, 20)
                        VStack(alignment: .leading) {
                            Text("Username \(username)")
                                .font(.callout)
                                .foregroundColor(Color.white)
                                .bold()
                            TextField(
                                            "Enter username...",
                                            text: ($username),
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
                        
                        NavigationLink(destination: CityWalks(viewModel: WeatherViewModel(weatherService: WeatherService()))) {
                            Text("Enter")
                                .foregroundColor(Color(red: 0.438, green: 0.862, blue: 1.0))
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
                        
                    }//.environmentObject(user)
                    .navigationBarColor(UIColor(Color(red: 0.483, green: 0.47, blue: 0.997)), textColor: .white)
                    .navigationBarTitle("Username")
                    .navigationBarHidden(true)
                }
            }
    }
}

struct Username_Previews: PreviewProvider {
    static var previews: some View {
        Username(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}
