//
//  OpenWeatherMapContainer.swift
//  WeatherApp
//
//  Created by ahmet berat can on 5.11.2023.
//

import Foundation


struct OpenWeatherMapContainer: Codable {
    var list: [OpenMapWeatherData]?
}

struct OpenMapWeatherData: Codable {
    var coord: OpenMapWeatherCoordinate
    var weather: [OpenMapWeatherWeather]
    var main: OpenMapWeatherMain
}

struct OpenMapWeatherCoordinate: Codable {
    var longtitute: Float?
    var latitute: Float?
}

struct OpenMapWeatherWeather: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct OpenMapWeatherMain: Codable {
    var temp: Float?
}
