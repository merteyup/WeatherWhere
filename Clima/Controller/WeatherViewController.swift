//
//  ViewController.swift
//  Clima
//
//  Created by Eyup Mert 10/04/2022.

// https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

import UIKit
import CoreLocation


class WeatherViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextView: UITextField!
    
    // MARK: Variables
    var weatherManager = WeatherManager()
    let locationManger = CLLocationManager()
    
    // MARK: IBActions
        
    @IBAction func locationPressed(_ sender: UIButton) {
        
        locationManger.requestLocation()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.requestLocation()
        
        searchTextView.delegate = self
        weatherManager.delegate = self

    }
  
}

// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    
    @IBAction func searchPressed(_ sender: Any) {
       searchTextView.endEditing(true)
       print(searchTextView.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextView.text!)
        searchTextView.endEditing(true)
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextView.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextView.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type Something Here"
            return false
        }
    }
    
}

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {

        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }

    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
       if let location = locations.last {
           locationManger.stopUpdatingLocation()
           let lat = location.coordinate.latitude
           let lon = location.coordinate.longitude
           print(lat)
           print(lon)
           weatherManager.fetchWeather(latitude: lat, longitude: lon)
           
        
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
