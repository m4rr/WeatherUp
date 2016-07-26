//
//  WeatherUpTests.swift
//  WeatherUpTests
//
//  Created by Marat S. on 25.07.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import XCTest
@testable import WeatherUp

class WeatherUpTests: XCTestCase {

  var weatherManager: WeatherManager?

  override func setUp() {
    super.setUp()

    weatherManager = WeatherManager()
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testWeatherAPI() {
    // Given.
    let input = [2759794]
    var output: [Weather] = []

    // Test api.openweathermap.org
    let expectation = expectationWithDescription("weather request")
    self.weatherManager?.obtain(input: input) { list in
      if list.count == input.count {
        output = list
        expectation.fulfill()
      }
    }

    self.waitForExpectationsWithTimeout(10) { error in
      XCTAssert(error == nil, "Should be nil")
    }

    XCTAssert(output.first?.city == "Amsterdam", "Should be Amsterdam")

    // Test weather icon image download.
    measureBlock() {
      let imageURL = output.first?.iconURL
      XCTAssert(imageURL != nil, "imageURL should not be nil")
      XCTAssert(imageURL != NSURL(), "imageURL should be an URL")

      /// - important: Synchronous!
      let imageData = NSData(contentsOfURL: imageURL!)
      XCTAssert(imageData != nil, "imageData should not be nil")

      let image: UIImage? = UIImage(data: imageData!)
      XCTAssert(image != nil, "image should not be nil")
      XCTAssert(image != UIImage(), "imageURL should be an image")
    }
  }

  func testWeatherBatch() {

    let input = [(2759794, "Amsterdam"),
                 (3128760, "Barcelona"),
                 (5341145, "Cupertino"),
                 ( 703448, "Kiev"),
                 (2643743, "London"),
                 ( 524901, "Moscow"),
                 (3143244, "Oslo"),
                 (3168070, "San Marino"),
                 (3133895, "Tromso"),
                 (2657896, "Zurich"),]
    let ids = input.flatMap { tuple in return tuple.0 }
    let expectation = expectationWithDescription("weather request")

    weatherManager?.obtain(input: ids) { list in
      if list.count == input.count {
        list.enumerate().forEach { index, element in
          XCTAssert(element.city == input[index].1, "City name should be equal to input's")
        }

        expectation.fulfill()
      }
    }

    waitForExpectationsWithTimeout(10) { error in
      XCTAssert(error == nil, "Should be nil")
    }
  }

  func testSigning() {
    let input: [String: AnyObject] = [:]
    let output = weatherManager?.signed(input)

    XCTAssert(output?["appid"] != nil , "Should provide `appid`")
  }

}
