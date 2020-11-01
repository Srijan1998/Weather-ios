//
//  WeatherManager.swift
//  Clima
//
//  Created by Srijan Bhatia on 24/10/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=7ecbe89f39ce1022e895fe14b95c7eaa&units=metric"
    let weatherURLll = "https://api.openweathermap.org/data/2.5/weather?appid=7ecbe89f39ce1022e895fe14b95c7eaa&units=metric"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeatherData(city: String)
    {
        let weatherString = "\(weatherURL)&q=\(city)"
        performRequest(urlString: weatherString)
    }
    
    func fetchWeatherDatall(lat: Double, lon: Double) {
        let weatherString = "\(weatherURLll)&lat=\(lat)&lon=\(lon)"
        performRequest(urlString: weatherString)
    }
    
    func performRequest(urlString: String)
    {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                }
                if let safeData = data {
                    let dataString = String(data: safeData, encoding: .utf8)
                    if let weather = parseJson(weatherData: safeData) {
                        delegate?.didUpdateWeather(weather: weather)
                    }
                }
            })
            
            task.resume()
        }
    }
    
    func parseJson(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            let weatherModel = WeatherModel(name: name, temp: temp, weatherId: id)
            print(weatherModel.conditionName)
            return weatherModel
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
