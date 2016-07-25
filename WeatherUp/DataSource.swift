//
//  Datasource.swift
//  WeatherUp
//
//  Created by Marat S. on 25.07.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import UIKit

private let weatherCellId = "weatherCell"

@objc protocol TableController: UITableViewDelegate, UITableViewDataSource {

  func obtainWeather(completion: (() -> Void)?)

}

class DataSource: NSObject, TableController {

  init(tableView: UITableView!, on viewController: UIViewController) {
    self.tableView = tableView
    self.viewController = viewController

    super.init()
  }

  private weak var tableView: UITableView!
  private weak var viewController: UIViewController!

  internal lazy var weatherManager: Weatherable = WeatherManager()

  internal lazy var detailedStyle = false
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

  func obtainWeather(completion: (() -> Void)? = nil) {
    weatherManager.weather(cities) { (list) in
      self.storage = list

      completion?()
    }
  }

}

extension DataSource: UITableViewDataSource {

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return storage.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCellWithIdentifier(weatherCellId, forIndexPath: indexPath)
  }

  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return storage.isEmpty ? "Loading..." : df.stringFromDate(NSDate())
  }

  func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    if storage.isEmpty {
      return nil
    } else {
      return String(format: "%d %@", storage.count, storage.count == 1 ? "city" : "cities")
    }
  }

}

extension DataSource: UITableViewDelegate {

  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    let weather = storage[indexPath.row]
    let temp = String(format: " %0.f°", weather.temp)
    let imageUrl = weatherManager.icon(of: weather)

    cell.textLabel?.text = {
      if detailedStyle {
        return (weather.city ?? "Unknown city") + (weather.country != nil ? (", " + weather.country!) : "")
      } else {
        return weather.city
      }
    }()

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

  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return cities.count > 1
  }

  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    switch editingStyle {
    case .Delete:
      tableView.beginUpdates()
      cities.removeAtIndex(indexPath.row)
      storage.removeAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
      tableView.endUpdates()
    default:
      ()
    }

    if cities.isEmpty {
      viewController.setEditing(false, animated: true)
    }
  }

  func tableView(tableView: UITableView, willBeginEditingRowAtIndexPath indexPath: NSIndexPath) {
    viewController.editing = true
  }

  func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath) {
    viewController.editing = false
  }
  
}
