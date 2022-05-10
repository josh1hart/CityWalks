//
//  CityWalks.swift
//  CityWalks
//
//  Created by Josh Hart on 18/03/2022.
//
import SwiftUI
import UIKit
import SwiftUICharts
import HealthKit

struct CityWalks: View {
    
    /*
    static let dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
        
    }()
    
    
    let steps: [Step]
    
    var totalSteps: Int {
        steps.map { $0.count }.reduce(0,+)
    }
    */
     
    @State var show = false
    @State private var showNavView = false
    @State private var showModalView = false
    @ObservedObject var viewModel: WeatherViewModel
    @ObservedObject var stepviewModel: StepViewModel
    //@State private var steps: [Step] = [Step]()
    @EnvironmentObject var csteps: CStep
    @State private var navigateTo: AnyView?
    @State private var isActive = false
    
    var body: some View {
            ZStack {
                Color(red: 0.165, green: 0.165, blue: 0.165).edgesIgnoringSafeArea(.all)
                ScrollView {
                    Text(" ")
                        .foregroundColor(.white)
                        .padding(.top, 5.0)
                        .environment(\.colorScheme, .dark)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    navigateTo = AnyView (PersonalWalks())
                                    isActive = true
                                }, label: {
                                    Label(
                                        title: { Text("PersonalWalks") },
                                        icon: { Image(systemName: "person") }
                                    )
                                })
                                //Below menu was not used, ux deamed pressing the button twice a pointless extra step
                                /*
                                 Menu {
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
                                        navigateTo = AnyView (ContentView())
                                        isActive = true
                                    }, label: {
                                        Label(
                                            title: { Text("CityWalks") },
                                            icon: { Image(systemName: "person.3") }
                                        )
                                    })
                                } label : {
                                    Label(
                                        title: {Text("Add")},
                                        icon: {Image(systemName: "plus")}
                                        
                                    )
                                }
                                 */
                                .background(
                                    NavigationLink(destination: self.navigateTo, isActive: $isActive) {
                                    })
                            }
                        }
                    ZStack {
                        //created a stroked circle for creating the animated ring
                        Circle()
                            .trim(from: show ? 0.5 : 0.25, to: 1) //0.1 = closer to 100 percent
                        //angular gradient that follows the ring
                            .stroke(AngularGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001), Color(red: 0.437, green: 0.911, blue: 1.001)]), center: .center, startAngle: .zero, endAngle: .degrees(360)), style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.degrees(90))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                            .frame(width: 250,height: 250)
                            .animation(.easeOut)
                            .padding()
                            .onTapGesture{
                                self.show.toggle()
                        }
                        //infomation inside the ring
                        VStack{
                            //title city
                            Text(viewModel.cityName)
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: 100.0, height: 5.0)
                            //the citys steps
                            Text("\(csteps.citysteps)")
                                .font(.largeTitle)
                                .foregroundColor(Color(red: 0.438, green: 0.862, blue: 1.0))
                                .padding(.bottom, 10.0)
                        }
                        Text("Active Users")
                            .foregroundColor(.white)
                            .padding(.top, 125.0)
                        Text("1,040")
                            .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.652))
                            .padding(.top, 165.0)
                    }.padding(.bottom, 20.0)
                        .padding(.top, 5.0)
                    //Bar Chart
                    ScrollView(showsIndicators: true){
                            VStack(spacing: 0) {
                                BarChartView(data: ChartData(values: [
                                    ("Mon", 5508),
                                    ("Tue", 7320),
                                    ("Wed", 8044),
                                    ("Thur", 2803),
                                    ("Fri", 1050),
                                    ("Sat", 3402),
                                    ("Sun", 8200),
                                ]),
                                             title: "Daily Steps", // name of chart
                                             style: Styles.barChartStyleNeonBlueLight, //color style
                                             form: ChartForm.extraLarge, // decides size of slide
                                             dropShadow: false, //removes drop shadow
                                             valueSpecifier: "%.0f" //removes .0 values
                                )
                                Text("Step count is the number of steps you take throughout the day. Pedometers and digital activity trackers can help you determine your step count. These devices count steps for any activity that involves steplike movement, including walking, running, stair-climbing, cross- country skiing, and even movement as you go about your daily chores.")
                                    .foregroundColor(Color.white)
                                    .padding()
                                //Line chart
                                LineChartView(data: [0,104,240,204,230,190],
                                              title: "Hourly Steps",
                                              style: Styles.barChartStyleNeonBlueLight, //color style
                                              form: ChartForm.extraLarge, // decides size of slide
                                              dropShadow: false, //removes drop shadow
                                              valueSpecifier: "%.0f"
                                ).padding(.top, 5)
                                //create a hourly legend for the chart
                                ZStack {
                                    HStack{
                                        Capsule().frame(width: 365, height: 30)
                                            .foregroundColor(Color.white/*(hue: 0.674, saturation: 0.028, brightness: 0.906)*/)
                                    }.padding(.top, 10)
                                    //create a hstack for listing the hours
                                    HStack{
                                        Text("7am").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.top, 8)
                                        Text("9am").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.top, 8)
                                        Text("11am").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.top, 8)
                                        Text("1pm").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.top, 8)
                                        Text("3pm").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.top, 8)
                                        Text("5pm").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.top, 8)
                                        Text("7pm").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.top, 8)
                                        Text("9pm").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.top, 8)
                                    }
                                }
                            }
                    }.padding(.bottom, 10.0)
                    
                    //Start of leaderboard section
                    Text("Leaderboard")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 10.0)
                        .padding(.leading, 17)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    //start of leaderboard
                    ZStack {
                        //background card
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.white)
                            .frame(width: 365, height: 330)
                        HStack{
                            //list of city names
                            VStack(alignment: .trailing){
                                    Text("London").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                    Text("Bristol").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                    Text("Caradiff").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                    Text("Manchester").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                    Text("Edinburgh").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                    Text("Oxford").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                    Text("Bath").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                    Text("Cambridge").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                            }
                            VStack{
                                //Progress bars starting with gray unfilled bars
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //filled bar
                                    Capsule()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001)]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 210, height: 30)
                                    //Text steps
                                    Text("20,002,349").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001)]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 180, height: 30)
                                    //uses global for the users city steps
                                    Text("\(csteps.citysteps)").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001)]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 170, height: 30)
                                    Text("15,002,349").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001)]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 150, height: 30)
                                    Text("13,002,349").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001)]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 130, height: 30)
                                    Text("12,002,349").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001)]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 120, height: 30)
                                    Text("10,002,349").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001)]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 100, height: 30)
                                    Text("9,002,349").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001)]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 70, height: 30)
                                    Text("6,002,349").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                            }
                        }
                    }
                    //ex code for trying to print total Steps from a new view
                    //Text("Total Steps: \(totalSteps)")
                }.onAppear(perform: viewModel.refresh)
            }.environmentObject(csteps)
            .navigationBarColor(UIColor(Color(red: 0.483, green: 0.47, blue: 0.997)), textColor: .white)
                .navigationBarTitle("\(viewModel.cityName) Walks")
                //.navigationBarHidden(true)
    }
}

struct CityWalks_Previews: PreviewProvider {
    static var previews: some View {
        CityWalks(viewModel: WeatherViewModel(weatherService: WeatherService()), stepviewModel: StepViewModel(healthStore: HealthStore()))
    }
}

