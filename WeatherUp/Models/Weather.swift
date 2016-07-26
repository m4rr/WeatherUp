//
//  Weather.swift
//  WeatherUp
//
//  Created by Marat S. on 25.07.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import Foundation
import ObjectMapper

private let imagePath = "http://openweathermap.org/img/w/"

class Weather: Mappable {

  var country: String?
  var city: String?
  var cityID: Int?
  var text: String?
  var temp: Double = 0
  var iconID: String = ""
  var iconURL: NSURL {
    return NSURL(string: imagePath + "\(iconID).png") ?? NSURL()
  }

  required init?(_ map: Map) {

  }

  func mapping(map: Map) {
    country  <- map["sys.country"]
    city     <- map["name"]
    cityID   <- map["id"]
    text     <- map["weather.0.description"]
    iconID   <- map["weather.0.icon"]
    temp     <- map["main.temp"]
  }

}
