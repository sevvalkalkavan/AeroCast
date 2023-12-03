//
//  Weather.swift
//  AeroCast
//
//  Created by Şevval Kalkavan on 3.12.2023.
//

import Foundation

class WeatherData: Codable{
    var name: String?
    var id: Int?
    var main: Main?
    var weather : [Weather]?
}
