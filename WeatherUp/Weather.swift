//
//  Weather.swift
//  WeatherUp
//
//  Created by Marat S. on 25.07.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import Foundation
import ObjectMapper

class Weather: Mappable {

  var country: String?
  var city: String?
  var cityId: Int?
  var text: String?
  var iconId: String = ""
  var temp: Double = 0

  required init?(_ map: Map) {

  }

  func mapping(map: Map) {
    country  <- map["sys.country"]
    city     <- map["name"]
    cityId   <- map["id"]
    text     <- map["weather.0.description"]
    iconId   <- map["weather.0.icon"]
    temp     <- map["main.temp"]
  }

}
