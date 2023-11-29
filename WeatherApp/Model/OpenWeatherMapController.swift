//
//  OpenWeatherMapController.swift
//  WeatherApp
//
//  Created by ahmet berat can on 4.11.2023.
//

import Foundation

private enum API {
    static let key = "38fa670a214428c0d24ced74e2ba6476"
}

class OpenWeatherMapController: WebServiceController {
    func fetchWeatherData(for city: String, completionHandler: @escaping (String?, WebServiceControllerError?) -> Void) {
        // https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
        let endPoint = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(API.key)"
        
        guard let safeURLString = endPoint.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
              let endpointURL = URL(string: safeURLString) else {
            completionHandler(nil, WebServiceControllerError.invlaidURL(endPoint))
            return
            
        }
        
        let dataTask = URLSession.shared.dataTask(with: endpointURL) { (data, response, error) in
            guard error == nil else {
                completionHandler(nil, WebServiceControllerError.forwarded(error!))
                return
            }
            
            guard let responseData = data else {
                completionHandler(nil, WebServiceControllerError.invalidPayload(endpointURL))
                return
            }
            
            // decode JSON
            let decoder = JSONDecoder()
            do {
                
                let jsonArray = try JSONSerialization.jsonObject(with: responseData)
                print(jsonArray)
                
                var info = OpenWeatherMapContainer.self
                let weatherList = try decoder.decode(info, from: responseData)
                guard let weatherInfo = weatherList.list?.first, let weather = weatherInfo.weather.first?.main, let temperature = weatherInfo.main.temp else {
                    completionHandler(nil, WebServiceControllerError.invalidPayload((endpointURL)))
                    return
                }
                
                // compose weather information
                let weatherDescription = "\(weather) \(temperature) F"
                completionHandler(weatherDescription, nil)
            } catch let error {
                completionHandler(nil, WebServiceControllerError.forwarded(error))
            }
        }
        dataTask.resume()
    }
}
