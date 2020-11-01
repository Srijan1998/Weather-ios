//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by Srijan Bhatia on 25/10/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(error: Error)
}
