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

}

final class WeatherManager: Weatherable {

  func weather(cities: [Int], completion: ([AnyObject]) -> Void) -> Void {



    Alamofire.Manager.sharedInstance.request(.GET,
                                             "http://api.openweathermap.org/data/2.5/group",
                                             parameters: [
                                              "appid": apiKey,
                                              "units": "metric",
                                              "id": "524901,703448,2643743",
      ],
                                             encoding: ParameterEncoding.URL, headers: nil)

    .responseJSON { (responseResponse) in
      print(responseResponse.result.value)
    }
  }

}
