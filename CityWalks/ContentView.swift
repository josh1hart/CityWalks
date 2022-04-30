//
//  ContentView.swift
//  CityWalks
//
//  Created by Josh Hart on 18/03/2022.
//
import SwiftUI
import SwiftUICharts

struct ContentView: View {
    
    /*
    @ObservedObject var viewModel: WeatherViewModel
    public var PageName = "City"
    */
     
    @State var show = false
    @State private var showNavView = false
    @State private var showModalView = false
    @ObservedObject var viewModel: WeatherViewModel
    
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
    
    @State private var navigateTo: AnyView?
    @State private var isActive = false
    
    var body: some View {
        NavigationView{
            ZStack {
                Color(red: 0.228, green: 0.228, blue: 0.228).edgesIgnoringSafeArea(.all)
                ScrollView {
                    Text(" ")
                        .foregroundColor(.white)
                        .padding(.top, 5.0)
                        .foregroundColor(.white)
                        
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
                                /*Menu {
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
                                }*/
                                .background(
                                    NavigationLink(destination: self.navigateTo, isActive: $isActive) {
                                        //EmptyView()
                                    })
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
                            Text(viewModel.cityName)
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: 100.0, height: 5.0)
                            Text("20,002,349")
                                .font(.largeTitle)
                                .foregroundColor(Color(red: 0.35, green: 0.893, blue: 0.926))
                                .padding(.bottom, 10.0)
                        }
                        Text("Active Users")
                            .foregroundColor(.white)
                            .padding(.top, 125.0)
                        Text("1,040")
                            .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.652))
                            .padding(.top, 165.0)
                    }
                    //Bar Chart
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
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
                            ).padding(.top, 20.0)
                                .padding(.trailing,10.0)
                            //line chart
                            LineChartView(data: [0,104,240,204,230,190],
                                          title: "Hourly Steps",
                                          style: Styles.barChartStyleNeonBlueLight, //color style
                                          form: ChartForm.extraLarge, // decides size of slide
                                          dropShadow: false, //removes drop shadow
                                          valueSpecifier: "%.0f"
                            ).padding(.top, 20.0)
                            .padding(.leading, 20.0)
                        }
                        .padding(.horizontal, 15.0)
                    }

                    
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque venenatis vestibulum turpis eu interdum. Vivamus vel fermentum nisl. Donec quis felis nec eros pretium vulputate. Proin rutrum ullamcorper risus, eget suscipit odio sollicitudin id. Sed id libero convallis, viverra neque et, venenatis ex. Suspendisse ornare, arcu nec eleifend blandit, velit erat varius est, quis ornare mi eros in erat.")
                        .foregroundColor(Color.white)
                        .padding()
                    
                    HStack{
                        VStack(alignment: .leading){
                                Text("London").fontWeight(.bold).foregroundColor(.white).padding(.vertical, 5)
                                Text("Bristol").fontWeight(.bold).foregroundColor(.white).padding(.vertical, 5)
                                Text("Bath").fontWeight(.bold).foregroundColor(.white).padding(.vertical, 5)
                                Text("Newquay").fontWeight(.bold).foregroundColor(.white).padding(.bottom, 5)
                                Text("Edinbourgh").fontWeight(.bold).foregroundColor(.white).padding(.top, 5)
                                Text("Cardiff").fontWeight(.bold).foregroundColor(.white).padding(.vertical, 5)
                                Text("Newport").fontWeight(.bold).foregroundColor(.white).padding(.vertical, 5)
                                Text("Swindon").fontWeight(.bold).foregroundColor(.white).padding(.vertical, 5)
                        }
                        VStack{
                            ZStack(alignment: .leading) {
                                Capsule().frame(width: 250, height: 30)
                                    .foregroundColor(Color.white)
                                //fill
                                Capsule().frame(width: 200, height: 30)
                                    .foregroundColor(Color(red: 0.349, green: 0.893, blue: 0.926))
                            }
                            
                            ZStack(alignment: .leading) {
                                Capsule().frame(width: 250, height: 30)
                                    .foregroundColor(Color.white)
                                //fill
                                Capsule().frame(width: 189, height: 30)
                                    .foregroundColor(Color(red: 0.349, green: 0.893, blue: 0.926))
                            }
                            ZStack(alignment: .leading) {
                                Capsule().frame(width: 250, height: 30)
                                    .foregroundColor(Color.white)
                                //fill
                                Capsule().frame(width: 140, height: 30)
                                    .foregroundColor(Color(red: 0.349, green: 0.893, blue: 0.926))
                            }
                            ZStack(alignment: .leading) {
                                Capsule().frame(width: 250, height: 30)
                                    .foregroundColor(Color.white)
                                //fill
                                Capsule().frame(width: 120, height: 30)
                                    .foregroundColor(Color(red: 0.349, green: 0.893, blue: 0.926))
                            }
                            ZStack(alignment: .leading) {
                                Capsule().frame(width: 250, height: 30)
                                    .foregroundColor(Color.white)
                                //fill
                                Capsule().frame(width: 97, height: 30)
                                    .foregroundColor(Color(red: 0.349, green: 0.893, blue: 0.926))
                            }
                            
                            ZStack(alignment: .leading) {
                                Capsule().frame(width: 250, height: 30)
                                    .foregroundColor(Color.white)
                                
                                Capsule().frame(width: 85, height: 30)
                                    .foregroundColor(Color(red: 0.349, green: 0.893, blue: 0.926))
                            }
                            ZStack(alignment: .leading) {
                                Capsule().frame(width: 250, height: 30)
                                    .foregroundColor(Color.white)
                                //fill
                                Capsule().frame(width: 75, height: 30)
                                    .foregroundColor(Color(red: 0.349, green: 0.893, blue: 0.926))
                            }
                            ZStack(alignment: .leading) {
                                Capsule().frame(width: 250, height: 30)
                                    .foregroundColor(Color.white)
                                //fill
                                Capsule().frame(width: 50, height: 30)
                                    .foregroundColor(Color(red: 0.349, green: 0.893, blue: 0.926))
                            }
                        }
                    }
                        
                    /*
                    BarChartView(data: ChartData(values: [
                        ("Bristol", 20000200),
                        ("Bath", 18000200),
                        ("London", 15000200),
                        ("Torquay", 14000200),
                        ("Newquay", 13000200),
                        ("Cardiff", 10000200),
                        ("Plymouth", 7000200),
                    ]),
                                 title: "", // name of chart
                                 style: Styles.barChartStyleNeonBlueLight, //color style
                                 form: ChartForm.extraLarge, // decides size of slide
                                 dropShadow: false, //removes drop shadow
                                 valueSpecifier: "%.0f" //removes .0 values
                    ).padding(.vertical, 60.0).rotationEffect(.degrees(90))*/
                }.onAppear(perform: viewModel.refresh)
            }
            .navigationBarColor(.gray, textColor: .white)
            .navigationBarTitle("\(viewModel.cityName) Walks")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}

