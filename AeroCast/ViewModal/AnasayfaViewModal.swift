//
//  AnasayfaViewModal.swift
//  AeroCast
//
//  Created by Şevval Kalkavan on 3.12.2023.
//

import Foundation
import Alamofire
import CoreLocation

class AnasayfaViewModal{
    
    var wrepo = DaoRepository()
    
    func fetchWeather(cityName: String, completion: @escaping (WeatherData) -> Void) {
        wrepo.fetchWeather(cityName: cityName, completion: completion)
    }
    
    func conditionWeather(conditionID: Int ) -> String{
        wrepo.conditionWeather(conditionID: conditionID)
    }
    func featchWeather(latitude : CLLocationDegrees , longitude : CLLocationDegrees, completion: @escaping (WeatherData) -> Void){
        wrepo.featchWeather(latitude: latitude, longitude: longitude, completion: completion)
    }
}
