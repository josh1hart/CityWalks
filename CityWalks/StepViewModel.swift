//
//  StepViewModel.swift
//  CityWalks
//
//  Created by Josh Hart on 07/05/2022.
//


import Foundation
import HealthKit

public class StepViewModel: ObservableObject{
    @Published var healthStore: HealthStore?
    
    //public let healthStore: HealthStore
    
    
    public init(healthStore: HealthStore){
        self.healthStore = HealthStore()
    }
    
    
}

