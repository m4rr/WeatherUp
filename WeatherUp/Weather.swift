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

  var city: City?
  var text: String?
  var iconId: String?

  required init?(_ map: Map) {

  }

  func mapping(map: Map) {
    city     <- map
    text     <- map["weather.0.description"]
    iconId   <- map["weather.0.icon"]
  }

}
