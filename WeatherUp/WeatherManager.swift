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
private let apiURL = "http://api.openweathermap.org/data/2.5/"

final class WeatherManager: APIable {

  func obtain(input ids: [Int], completion: ([Weather]) -> Void) {
    let requestUrl = apiURL + "group"
    let parameters = [
      "id": ids.reduce("", combine: { $0 + "," + String($1) }),
      "units": "metric",
    ]

    Alamofire.Manager.sharedInstance
      .request(.GET, requestUrl, parameters: signed(parameters))
      .responseArray(queue: nil, keyPath: "list", context: nil) { (response: Response<[Weather], NSError>) in
        switch response.result {
        case .Success(let list):
          completion(list)
        case .Failure(_):
          completion([])
        }
    }
  }

  private func signed(parameters: [String: AnyObject]) -> [String: AnyObject] {
    var ps = parameters
    ps["appid"] = apiKey

    return ps
  }

}
