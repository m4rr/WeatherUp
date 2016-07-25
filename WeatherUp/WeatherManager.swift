//
//  WeatherManager.swift
//  WeatherUp
//
//  Created by Marat S. on 25.07.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

private let apiKey = "c87d3cb245cac521a3c7b03f56d2dd4c"

protocol Weatherable {

  func weather(cities: [Int], completion: ([Weather]) -> Void)

  func icon(of weather: Weather) -> NSURL

}

final class WeatherManager: Weatherable {

  func weather(cities: [Int], completion: ([Weather]) -> Void) {
    let parameters = [
      "id": "524901,703448,2643743",
      "units": "metric",
    ]

    Alamofire.Manager.sharedInstance
      .request(.GET,
        "http://api.openweathermap.org/data/2.5/group",
        parameters: signed(parameters: parameters))
      .responseArray(queue: nil, keyPath: "list", context: nil) { (response: Response<[Weather], NSError>) in
        switch response.result {
        case .Success(let list):
          completion(list)
        case .Failure(_):
          completion([])
        }
    }

  }

  func icon(of weather: Weather) -> NSURL {
    return NSURL(string: "http://openweathermap.org/img/w/\(weather.iconId).png")!
  }

  private func signed(parameters ps: [String: AnyObject]) -> [String: AnyObject] {
    var parameters = ps
    parameters["appid"] = apiKey

    return parameters
  }

}
