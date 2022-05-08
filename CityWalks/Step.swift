//
//  Step.swift
//  CityWalks
//
//  Created by Josh Hart on 07/05/2022.
//

import Foundation

struct Step: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}
