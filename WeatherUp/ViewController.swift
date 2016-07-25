//
//  ViewController.swift
//  WeatherUp
//
//  Created by Marat S. on 25.07.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let weatherManager: Weatherable = WeatherManager()

  override func viewDidLoad() {
    super.viewDidLoad()

//    weatherManager.weather(<#T##cities: [Int]##[Int]#>, completion: <#T##([AnyObject]) -> Void#>)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

