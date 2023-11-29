//
//  WebServiceController.swift
//  WeatherApp
//
//  Created by ahmet berat can on 4.11.2023.
//

import Foundation


public enum WebServiceControllerError: Error {
    case invlaidURL(String)
    case invalidPayload(URL)
    case forwarded(Error)
}

public protocol WebServiceController {
    func fetchWeatherData(for city: String,
                          completionHandler: @escaping (String?, WebServiceControllerError?) -> Void)
}
