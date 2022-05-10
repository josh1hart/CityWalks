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

struct PersonalWalks: View {
    @State var show = false
    
    //global name
    @EnvironmentObject var user: User
    @EnvironmentObject var usteps: UStep
    
    var body: some View {
            ZStack {
                //background colour
                Color(red: 0.165, green: 0.165, blue: 0.165).edgesIgnoringSafeArea(.all)
                ScrollView {
                    Text(" ")
                        .foregroundColor(.white)
                        .padding(.top, 5.0)
                        .environment(\.colorScheme, .dark)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                
                                //ex sub menu can be reimplemented for a chance to have multiple pages
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
                    
                    //Ring creation
                    ZStack {
                        Circle()
                            .trim(from: show ? 0.5 : 0.25, to: 1) //0.1 = closer to 100 percent
                            .stroke(AngularGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001), Color(red: 0.437, green: 0.911, blue: 1.001)]), center: .center, startAngle: .zero, endAngle: .degrees(360)), style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.degrees(90))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                            .frame(width: 250,height: 250)
                            .animation(.easeOut)
                            .padding()
                            .onTapGesture{
                                self.show.toggle()
                        }
                        //text inside the ring
                        VStack{
                            //the user global name var
                            Text(user.name)
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: 100.0, height: 5.0)
                            //user steps
                            Text("\(usteps.usersteps)")
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
                    }.padding(.bottom, 20.0)
                        .padding(.top, 5.0)
                    //Bar Chart
                    ScrollView(showsIndicators: true){
                        VStack(spacing: 0) {
                            BarChartView(data: ChartData(values: [
                                ("Mon", 558),
                                ("Tue", 732),
                                ("Wed", 844),
                                ("Thur", 283),
                                ("Fri", 150),
                                ("Sat", 342),
                                ("Sun", 820),
                            ]),
                                         title: "Daily Steps", // name of chart
                                         style: Styles.barChartStyleNeonBlueLight, //color style
                                         form: ChartForm.extraLarge, // decides size of slide
                                         dropShadow: false, //removes drop shadow
                                         valueSpecifier: "%.0f" //removes .0 values
                            )
                            Text("Step count is the number of steps you take throughout the day. Pedometers and digital activity trackers can help you determine your step count. These devices count steps for any activity that involves steplike movement, including walking, running, stair-climbing, cross- country skiing, and even movement as you go about your daily chores." )
                                .foregroundColor(Color.white)
                                .padding()
                            //Line chart
                            LineChartView(data: [12,32,21,24,23,19],
                                          title: "Hourly Steps",
                                          style: Styles.barChartStyleNeonBlueLight, //color style
                                          form: ChartForm.extraLarge, // decides size of slide
                                          dropShadow: false, //removes drop shadow
                                          valueSpecifier: "%.0f"
                            ).padding(.top, 5.0)
                            //line chart hourly legend
                            ZStack {
                                HStack{
                                    //background
                                    Capsule().frame(width: 365, height: 30)
                                        .foregroundColor(Color.white)
                                }.padding(.top, 10)
                                //listed hours
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

                    //title leaderboard section
                    Text("Leaderboard")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 10.0)
                        .padding(.leading, 17)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ZStack {
                        //leaderboard background card
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.white)
                            .frame(width: 365, height: 330)
                        HStack{
                            //list of usernames
                            VStack(alignment: .trailing){
                                    Text("Lucy").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                    Text("Dan").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                    Text("Jess").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                    Text("Kieran").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                    Text("Liam").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                    Text("Grace").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                //username inputted used here
                                    Text(user.name).fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                                    Text("Ellie").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.vertical, 5)
                            }
                            //creation of progress bars
                            VStack{
                                ZStack(alignment: .leading) {
                                    //grayed out bar
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //filled out progress bar
                                    Capsule()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001)]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 200, height: 30)
                                        //.clipShape(Capsule())
                                    Text("15,342").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001)]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 189, height: 30)
                                    Text("14,238").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001)]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 140, height: 30)
                                    Text("14,132").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001)]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 120, height: 30)
                                    Text("13,923").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001)]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 97, height: 30)
                                    Text("7,487").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001)]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 85, height: 30)
                                    Text("10,130").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001)]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 75, height: 30)
                                    Text("\(usteps.usersteps)").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: 230, height: 30)
                                        .foregroundColor(Color(hue: 0.674, saturation: 0.028, brightness: 0.906))
                                    //fill
                                    Capsule()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.437, green: 0.911, blue: 1.001), Color(red: 0.479, green: 0.466, blue: 1.001)]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 50, height: 30)
                                    Text("6,874").fontWeight(.bold).foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)).padding(.leading, 20.0)
                                }
                            }
                        }
                    }
                }
            }//init global vars with this view
            .environmentObject(user)
            .environmentObject(usteps)
        //colour nav bar elements
            .navigationBarColor(UIColor(Color(red: 0.483, green: 0.47, blue: 0.997)), textColor: .white)
            .navigationBarTitle("\(user.name) Walks")
    }
}


struct PersonalWalks_Previews: PreviewProvider {
    static var previews: some View {
        PersonalWalks(/*viewModel: WeatherViewModel(weatherService: WeatherService())*/)
    }
}

