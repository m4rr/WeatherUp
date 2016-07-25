//
//  WeatherManager.swift
//  WeatherUp
//
//  Created by Marat S. on 25.07.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import Foundation
import Alamofire

private let apiKey = "c87d3cb245cac521a3c7b03f56d2dd4c"

protocol Weatherable {

  func weather(cities: [Int], completion: ([AnyObject]) -> Void)

  func icon(of weather: Weather) -> URLStringConvertible

}

final class WeatherManager: Weatherable {

  func weather(cities: [Int], completion: ([AnyObject]) -> Void) {
    let parameters = [
      "id": "524901,703448,2643743",
      "units": "metric",
    ]

    Alamofire.Manager.sharedInstance
      .request(.GET,
        "http://api.openweathermap.org/data/2.5/group",
        parameters: signed(parameters: parameters),
        encoding: ParameterEncoding.URL, headers: nil)
      .responseJSON { (responseResponse) in
        print(responseResponse.result.value)
    }
  }

  func icon(of weather: Weather) -> URLStringConvertible {
    return "http://openweathermap.org/img/w/\(weather.iconId).png"
  }

  private func signed(parameters ps: [String: AnyObject]) -> [String: AnyObject] {
    var parameters = ps
    parameters["appid"] = apiKey

    return parameters
  }

}
