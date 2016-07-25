//
//  Datasource.swift
//  WeatherUp
//
//  Created by Marat S. on 25.07.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import UIKit

private let weatherCellId = "weatherCell"

extension ViewController: UITableViewDataSource {

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

extension ViewController: UITableViewDelegate {

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
      setEditing(false, animated: true)
      navigationItem.rightBarButtonItem?.enabled = false
    }
  }

  func tableView(tableView: UITableView, willBeginEditingRowAtIndexPath indexPath: NSIndexPath) {
    editing = true
  }

  func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath) {
    editing = false
  }
  
}
