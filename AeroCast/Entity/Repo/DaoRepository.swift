//
//  DaoRepository.swift
//  AeroCast
//
//  Created by Şevval Kalkavan on 3.12.2023.
//

import Foundation
import Alamofire
import CoreLocation

class DaoRepository{
    
    func fetchWeather(cityName: String, completion: @escaping (WeatherData) -> Void) {
        AF.request("https://api.openweathermap.org/data/2.5/weather?appid=947793cd25fe9a9489996c80fcb32d13&units=metric&q=\(cityName)", method: .get).response { response in
            if let data = response.data {
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                    completion(weatherData)
                    print(weatherData.name!)
                    print(weatherData.id!)
                    print(weatherData.main?.temp ?? 0.0)
                    print(weatherData.weather?[0].id)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func featchWeather(latitude : CLLocationDegrees , longitude : CLLocationDegrees, completion: @escaping (WeatherData) -> Void){
        AF.request("https://api.openweathermap.org/data/2.5/weather?appid=947793cd25fe9a9489996c80fcb32d13&units=metric&lat=\(latitude)&lon=\(longitude)", method: .get).response { response in
            if let data = response.data {
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                    completion(weatherData)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func conditionWeather(conditionID: Int ) -> String{
        switch conditionID {
        case 200...232:
            return "cloud"
        case 300...321:
            return "winter"
        case 500...531:
            return "lighting"
        case 600...622:
            return "winter"
        case 701...781:
            return "cloud"
        case 800:
            return "sunny"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
    
    
    
}
