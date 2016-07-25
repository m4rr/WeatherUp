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

  let weatherManager: Weatherable = WeatherManager()

  @IBOutlet weak var tableView: UITableView!

  private var storage: [Weather] = [] {
    didSet {
      tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.rightBarButtonItem = editButtonItem()
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    weatherManager.weather([]) { (list) in
      self.storage = list
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

}

extension ViewController: UITableViewDelegate {

  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    let weather = storage[indexPath.row]
    let imageUrl = weatherManager.icon(of: weather)

    cell.textLabel?.text = weather.city
    cell.detailTextLabel?.text = weather.text
    cell.imageView?.image = UIImage(named: "weather_image_placeholder")
    cell.imageView?.af_setImageWithURL(imageUrl, imageTransition: .CrossDissolve(0.1))
  }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }

}
