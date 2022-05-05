//
//  ContentView.swift
//  CityWalks
//
//  Created by Josh Hart on 18/03/2022.
//
import SwiftUI
import UIKit
import SwiftUICharts



struct PersonalWalks: View {
    
    /*
    @ObservedObject var viewModel: WeatherViewModel
    public var PageName = "City"
    */
    
    @State var show = false
    //@State public var username: username
    
    //@EnvironmentObject var info: UserInfo
    
    /*
    @State private var showNavView = false
    @State private var showModalView = false
     
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        navBarAppearance.backgroundColor = UIColor.gray
        navBarAppearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = UIColor.systemBackground
    }
    */
    /*
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(Color())]
    }
    */
    
    var body: some View {
            ZStack {
                Color(red: 0.228, green: 0.228, blue: 0.228).edgesIgnoringSafeArea(.all)
                ScrollView {
                    Text(" ")
                        .foregroundColor(.white)
                        .padding(.top, 5.0)
                        .environment(\.colorScheme, .dark)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                /*Menu {
                                    Button(action: {}, label: {
                                        Label(
                                            title: { Text("PersonalWalks") },
                                            icon: { Image(systemName: "person") }
                                        )
                                    })
                                    Button(action: {}, label: {
                                        Label(
                                            title: { Text("CityWalks") },
                                            icon: { Image(systemName: "person") }
                                        )
                                    })
                                } label : {
                                    Label(
                                        title: {Text("Add")},
                                        icon: {Image(systemName: "plus")}
                                        
                                    )
                                }*/
                            }
                        }
                    ZStack {
                        Circle()
                            .trim(from: show ? 0.5 : 0.25, to: 1) //0.1 = closer to 100 percent
                            .stroke(Color(red: 0.349, green: 0.893, blue: 0.926), style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.degrees(90))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                            .frame(width: 250,height: 250)
                            .animation(.easeOut)
                            .padding()
                            .onTapGesture{
                                self.show.toggle()
                        }
                        VStack{
                            Text("name")
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: 100.0, height: 5.0)
                            Text("7,567")
                                .font(.largeTitle)
                                .foregroundColor(Color(red: 0.35, green: 0.893, blue: 0.926))
                                .padding(.bottom, 10.0)
                        }
                        Text("Goal")
                            .foregroundColor(.white)
                            .padding(.top, 125.0)
                        Text("10,000")
                            .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.652))
                            .padding(.top, 165.0)
                    }
                    //Bar Chart
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            BarChartView(data: ChartData(values: [
                                ("Mon", 558),
                                ("Tue", 732),
                                ("Wed", 844),
                                ("Thur", 283),
                                ("Fri", 150),
                                ("Sat", 342),
                                ("Sun", 820),
                            ]),
                                         title: "Bar Chart", // name of chart
                                         style: Styles.barChartStyleNeonBlueLight, //color style
                                         form: ChartForm.extraLarge, // decides size of slide
                                         dropShadow: false, //removes drop shadow
                                         valueSpecifier: "%.0f" //removes .0 values
                            ).padding(.top, 20.0)
                                .padding(.trailing,10.0)
                            //line chart
                            LineChartView(data: [12,32,21,24,23,19],
                                          title: "Line Chart",
                                          style: Styles.barChartStyleNeonBlueLight, //color style
                                          form: ChartForm.extraLarge, // decides size of slide
                                          dropShadow: false, //removes drop shadow
                                          valueSpecifier: "%.0f"
                            ).padding(.top, 20.0)
                            .padding(.leading, 20.0)
                        }
                        .padding(.horizontal, 15.0)
                    }

                    
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque venenatis vestibulum turpis eu interdum. Vivamus vel fermentum nisl. Donec quis felis nec eros pretium vulputate. Proin rutrum ullamcorper risus, eget suscipit odio sollicitudin id. Sed id libero convallis, viverra neque et, venenatis ex." )
                        .foregroundColor(Color.white)
                        .padding()
                    
                    Text("Leaderboard")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 10.0)
                        .padding(.leading, 17)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.white)
                            .frame(width: 365, height: 330)
                        HStack{
                            VStack(alignment: .leading){
                                    Text("Lucy").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                    Text("Dan").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                    Text("Jess").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                    Text("Kieran").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                    Text("username").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                    Text("Grace").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                    Text("Liam").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                    Text("Ellie").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                            }
                            VStack{
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule().frame(width: 200, height: 30)
                                        .foregroundColor(Color(red: 0.438, green: 0.862, blue: 1.0))
                                        //.clipShape(Capsule())
                                    Text("15,342").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule().frame(width: 189, height: 30)
                                        .foregroundColor(Color(red: 0.438, green: 0.862, blue: 1.0))
                                    Text("14,238").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule().frame(width: 140, height: 30)
                                        .foregroundColor(Color(red: 0.438, green: 0.862, blue: 1.0))
                                    Text("14,132").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule().frame(width: 120, height: 30)
                                        .foregroundColor(Color(red: 0.438, green: 0.862, blue: 1.0))
                                    Text("13,923").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule().frame(width: 97, height: 30)
                                        .foregroundColor(Color(red: 0.438, green: 0.862, blue: 1.0))
                                    Text("12,293").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule().frame(width: 85, height: 30)
                                        .foregroundColor(Color(red: 0.438, green: 0.862, blue: 1.0))
                                    Text("10,130").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule().frame(width: 75, height: 30)
                                        .foregroundColor(Color(red: 0.438, green: 0.862, blue: 1.0))
                                    Text("9,609").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule().frame(width: 50, height: 30)
                                        .foregroundColor(Color(red: 0.438, green: 0.862, blue: 1.0))
                                    Text("6,874").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                            }
                        }
                    }
                }
            }.navigationBarColor(.gray, textColor: .white)
            .navigationBarTitle("Walks")
    }
}


struct PersonalWalks_Previews: PreviewProvider {
    static var previews: some View {
        PersonalWalks(/*viewModel: WeatherViewModel(weatherService: WeatherService())*/)
    }
}

