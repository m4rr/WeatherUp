//
//  APIable.swift
//  WeatherUp
//
//  Created by Marat S. on 26.07.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import Foundation
import ObjectMapper

protocol APIable {

  associatedtype Output: Mappable

  func obtain(input ids: [Int], completion: ([Output]) -> Void)

}
