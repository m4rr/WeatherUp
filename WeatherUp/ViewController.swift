//
//  ViewController.swift
//  WeatherUp
//
//  Created by Marat S. on 25.07.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

  @IBOutlet private weak var tableView: UITableView!
  private lazy var tableController: Tableable! = TableController(tableView: self.tableView, on: self)

  @IBOutlet private lazy var refreshControl: UIRefreshControl! = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(handleRefresh), forControlEvents: UIControlEvents.ValueChanged)

    return refreshControl
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.rightBarButtonItem = editButtonItem()

    tableView.dataSource = tableController
    tableView.delegate = tableController

    tableView.addSubview(refreshControl)
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    tableController.obtainWeather(nil)
  }

  @objc private func handleRefresh(refreshControl: UIRefreshControl) {
    refreshControl.beginRefreshing()

    tableController.obtainWeather { 
      refreshControl.endRefreshing()
    }
  }

  override func setEditing(editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)

    tableView.setEditing(editing, animated: animated)
  }

}
