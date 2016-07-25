//
//  TableController.swift
//  WeatherUp
//
//  Created by Marat S. on 26.07.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import UIKit

@objc protocol Tableable: UITableViewDataSource, UITableViewDelegate {

  func obtainWeather(completion: (() -> Void)?)

}
