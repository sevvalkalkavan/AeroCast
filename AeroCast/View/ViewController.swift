//
//  ViewController.swift
//  AeroCast
//
//  Created by Şevval Kalkavan on 2.12.2023.
//

import UIKit
import CoreLocation
class ViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
//    var weatherManagement = WeatherManagement()
    var locationManager = CLLocationManager()

    var viewModal = AnasayfaViewModal()
    
    var data = WeatherData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        //weatherManagement.delegate = self
        searchTextField.delegate = self

    }

    @IBAction func locationPressed(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text{
            //weatherManagement.featchWeather(cityName: city)
            viewModal.fetchWeather(cityName: city) { [weak self] weatherData in
               
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.cityLabel.text = weatherData.name
                    if let temperature = weatherData.main?.temp {
                        self.temperatureLabel.text = String(format: "%.1f", temperature)
                    }
                    self.backgroundImage.image = UIImage(named: self.viewModal.conditionWeather(conditionID: weatherData.weather?[0].id ?? 610))
                    
                }
            }
            
        }
        
        searchTextField.text = ""
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != ""{
            return true
        }else{
            searchTextField.placeholder = "Search something.."
            return false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let lat = location.coordinate.latitude
            let lot = location.coordinate.longitude
            viewModal.featchWeather(latitude: lat, longitude: lot) { [weak self] weatherData in
                
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.cityLabel.text = weatherData.name
                    if let temperature = weatherData.main?.temp {
                        self.temperatureLabel.text = String(format: "%.1f", temperature)
                    }
                    self.backgroundImage.image = UIImage(named: self.viewModal.conditionWeather(conditionID: weatherData.weather?[0].id ?? 610))
                    
                }
            }
            
           // weatherManagement.featchWeather(latitude : lat , longitude : lot)
        }

    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

//MARK: -CLLocationManagerDelegate
//extension ViewController : CLLocationManagerDelegate{
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last{
//            let lat = location.coordinate.latitude
//            let lot = location.coordinate.longitude
//            weatherManagement.featchWeather(latitude : lat , longitude : lot)
//        }
//
//    }
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error)
//    }
//}

////MARK: - WeatherManagerDelegate
//extension ViewController : WeatherManagerDelegate {
//    
//    func didUptadeWeather(_ weatherManager : WeatherManagement, weather : WeatherModel){
//        DispatchQueue.main.async {
//            self.temperatureLabel.text = weather.temperatureString
//            //self.conditionImageView.image = UIImage(systemName: weather.conditionPropert)
//            self.backgroundImage.image = UIImage(named: weather.conditionPropert)
//            self.cityLabel.text = weather.cityName
//        }
//        print(weather.temperature)
//    }
//    func didFailWithError(error : Error){
//        print(error)
//    }
//}

