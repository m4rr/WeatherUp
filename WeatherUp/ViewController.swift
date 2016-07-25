//
//  ViewController.swift
//  WeatherUp
//
//  Created by Marat S. on 25.07.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController {

  private let weatherManager: Weatherable = WeatherManager()
  private lazy var df: NSDateFormatter = {
    let df = NSDateFormatter()
    df.dateStyle = .MediumStyle
    df.timeStyle = .NoStyle

    return df
  }()

  @IBOutlet weak var tableView: UITableView!
  private var detailedStyle = false
  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(handleRefresh), forControlEvents: UIControlEvents.ValueChanged)

    return refreshControl
  }()

  private var storage: [Weather] = [] {
    didSet {
      tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

//    navigationItem.rightBarButtonItem = editButtonItem()

    tableView.addSubview(refreshControl)
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    obtainWeather()
  }

  private func obtainWeather(completion: (() -> Void)? = nil) {
    weatherManager.weather([]) { (list) in
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
}

private let weatherCellId = "weatherCell"

extension ViewController: UITableViewDataSource {

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return storage.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCellWithIdentifier(weatherCellId, forIndexPath: indexPath)
  }

  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      return storage.isEmpty ? nil : df.stringFromDate(NSDate())
    default:
      return nil
    }
  }

}

extension ViewController: UITableViewDelegate {

  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    let weather = storage[indexPath.row]
    let temp = String(format: " %0.f°", weather.temp)
    let imageUrl = weatherManager.icon(of: weather)

    cell.textLabel?.text = weather.city
    cell.detailTextLabel?.text = {
      if detailedStyle {
        return (weather.text != nil ? (weather.text! + ", ") : "") + temp
      } else {
        return weather.text
      }
    }()

    cell.imageView?.image = UIImage(named: "weather_image_placeholder")
    cell.imageView?.af_setImageWithURL(imageUrl, imageTransition: .CrossDissolve(0.3))
  }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    detailedStyle = !detailedStyle

    tableView.reloadRowsAtIndexPaths(tableView.indexPathsForVisibleRows ?? [indexPath], withRowAnimation: .Automatic)
  }

}
