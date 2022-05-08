//
//  WeatherData.swift
//  Clima
//
//  Created by Eyup Mert 10/04/2022.
//

import Foundation

// Get json
struct WeatherData : Decodable {
    // Get string from json
    let name : String
    
    // Get Double from Main Object
    let main : Main
    
    // Get String from Weather Array
    let weather : [Weather]
    
    
}

struct Main: Decodable {
    // Get Double from Main Object
    let temp: Double
}

struct Weather: Decodable {
    // Get String from Weather Array
    let id: Int
    let description: String
}
