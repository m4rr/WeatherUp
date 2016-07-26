//
//  TableController.swift
//  WeatherUp
//
//  Created by Marat S. on 26.07.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import UIKit

protocol Tableable: UITableViewDataSource, UITableViewDelegate {

  func refresh(completion: (() -> Void)?)

}
