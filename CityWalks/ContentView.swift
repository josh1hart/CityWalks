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

                    
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque venenatis vestibulum turpis eu interdum. Vivamus vel fermentum nisl. Donec quis felis nec eros pretium vulputate. Proin rutrum ullamcorper risus, eget suscipit odio sollicitudin id. Sed id libero convallis, viverra neque et, venenatis ex. Suspendisse ornare, arcu nec eleifend blandit, velit erat varius est, quis ornare mi eros in erat." /* Cras vestibulum, velit quis mattis varius, dolor velit iaculis tortor, id tempor elit dolor ac leo. In at mattis nisi, id lobortis felis. Etiam iaculis consequat sagittis. Nullam vulputate, turpis vel congue viverra, tellus enim auctor risus, vitae tincidunt urna est at leo. Sed eu malesuada urna. Integer sit amet augue id elit efficitur consequat eget et mi.Nunc malesuada est id mi congue tristique. Nulla sed convallis est. Proin vel elementum lectus, at lacinia augue. Donec ornare laoreet ante efficitur feugiat. Integer tincidunt orci neque, quis iaculis metus hendrerit non. Sed sagittis ante vitae blandit molestie. Etiam pellentesque enim in posuere interdum. Sed et nunc ac metus vestibulum eleifend. Sed iaculis ligula elit, ut cursus dolor euismod quis. Cras sit amet magna porta, mollis ex eget, mattis diam. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Vivamus eu maximus dolor. Duis ornare hendrerit augue, ac gravida ante rutrum id. Nulla lorem diam, fermentum id quam vel, mattis condimentum justo. Nulla in tellus sed tortor aliquam interdum eget at turpis. Donec eu consequat odio. Suspendisse a arcu hendrerit, malesuada nulla eu, placerat urna. Praesent hendrerit condimentum dolor in efficitur. Maecenas nec ipsum eu lacus tristique ultricies. Etiam sit amet viverra felis. Donec dapibus finibus dui vitae luctus. Donec in mollis sapien. Vestibulum iaculis arcu quis venenatis tempus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vivamus ac diam a purus lacinia auctor at ac sem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas non ligula sed ante sagittis aliquam. Aliquam in commodo neque, id molestie nisl. Vestibulum auctor augue lacinia, semper turpis eu, rhoncus sapien. Etiam viverra condimentum erat, eu ornare turpis feugiat eget. Nulla aliquam, elit commodo congue tincidunt, ante ligula iaculis orci, vel gravida turpis erat cursus mauris. Nam neque nibh, ullamcorper nec maximus in, porttitor id nisl. Donec ullamcorper eros interdum, ultricies nisi faucibus, pharetra arcu. Maecenas nec justo molestie, fermentum diam non, dictum enim. Nunc pretium ligula sit amet dui consequat accumsan. Quisque vel arcu in sem mattis accumsan efficitur ut velit. Pellentesque molestie neque nisi, sed ornare ante efficitur ut. Donec nulla erat, molestie a ornare vitae, bibendum sed erat. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed tristique tristique ipsum, sed laoreet velit consectetur in. Vivamus vitae elit ultricies, aliquam dolor sed, sollicitudin ligula. Donec eget quam ultricies, vulputate felis non, ullamcorper nunc. Pellentesque eget urna lacinia, vulputate metus id, feugiat nisi. Cras ligula turpis, rhoncus non ornare vel, efficitur nec quam."*/)
                        .foregroundColor(Color.white)
                        .padding()
                    
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
                    ).padding(.vertical, 60.0).rotationEffect(.degrees(90))
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

