//
//  ViewController.swift
//  WeatherUp
//
//  Created by Marat S. on 25.07.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import UIKit
import AlamofireImage

final class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(handleRefresh), forControlEvents: UIControlEvents.ValueChanged)

    return refreshControl
  }()

  internal lazy var detailedStyle = false
  internal lazy var weatherManager: Weatherable = WeatherManager()
  internal lazy var cities: [Int] = [2759794,3128760,5341145,703448,2643743,524901,3143244,3168070,3133895,2657896]

  internal var storage: [Weather] = [] {
    didSet {
      tableView.reloadData()
    }
  }

  internal lazy var df: NSDateFormatter = {
    let df = NSDateFormatter()
    df.dateStyle = .MediumStyle
    df.timeStyle = .NoStyle

    return df
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.rightBarButtonItem = editButtonItem()

    tableView.addSubview(refreshControl)
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    obtainWeather()
  }

  private func obtainWeather(completion: (() -> Void)? = nil) {
    weatherManager.weather(cities) { (list) in
      self.storage = list

      completion?()
    }
  }

  @objc private func handleRefresh(refreshControl: UIRefreshControl) {
    refreshControl.beginRefreshing()

    obtainWeather { 
      refreshControl.endRefreshing()
    }
  }

  override func setEditing(editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)

    tableView.setEditing(editing, animated: animated)
  }

}

