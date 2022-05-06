//
//  ContentView.swift
//  CityWalks
//
//  Created by Josh Hart on 18/03/2022.
//
import SwiftUI
import UIKit
import SwiftUICharts

@MainActor class User: ObservableObject{
    @Published var name = ""
}


struct ContentView: View {
    
    @StateObject var user = User()
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
