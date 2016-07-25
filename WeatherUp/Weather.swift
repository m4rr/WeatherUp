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

  var name = "<no name>"
//  var weather = <#value#>
  var mainDescription = "", detailDescription = ""
  var iconId = ""

  required init?(_ map: Map) {

  }

  func mapping(map: Map) {
    name <- map["name"]
    mainDescription   <- map["weather.0.main"]
    detailDescription <- map["weather.0.description"]
    iconId            <- map["weather.0.icon"]
  }

}
