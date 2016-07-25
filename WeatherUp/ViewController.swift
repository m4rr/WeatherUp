//
//  ViewController.swift
//  WeatherUp
//
//  Created by Marat S. on 25.07.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let weatherManager = WeatherManager()

  override func viewDidLoad() {
    super.viewDidLoad()

    weatherManager.weather([]) { (objects: [AnyObject]) in
      
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

