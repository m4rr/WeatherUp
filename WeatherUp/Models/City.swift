//
//  City.swift
//  WeatherUp
//
//  Created by Marat S. on 25.07.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import Foundation
import ObjectMapper

class City: Mappable {

  var id: String?
  var name: String?
  var country: String?

  required init?(_ map: Map) {

  }

  func mapping(map: Map) {
    id      <- map["sys.id"]
    name    <- map["name"]
    country <- map["sys.country"]
  }

}
