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
    let expectation = expectationWithDescription("weather request")

    weatherManager?.obtain(input: input) { list in
      if list.count == 1 {
        XCTAssert(list.first?.city == "Amsterdam", "Should be Amsterdam")

        expectation.fulfill()
      }
    }

    waitForExpectationsWithTimeout(10) { error in
      XCTAssert(error == nil, "Should be nil")
    }
  }

}
