//
//  BohriumTests.swift
//  BohriumTests
//
//  Created by Bas van Kuijck on 17-08-16.
//  Copyright © 2016 E-sites. All rights reserved.
//

import XCTest
@testable import Bohrium

class BohriumTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    func testIt() {
        let exp = self.expectation(description: "test")
        let timer = Bohrium.Timer(name: "test123", autoStart: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertGreaterThan(timer.lapTime, 0.9)
            timer.tick("tick")
            XCTAssertLessThan(timer.lapTime, 0.1)
            XCTAssertGreaterThan(timer.totalTime, 0.9)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                XCTAssertGreaterThan(timer.lapTime, 0.9)
                XCTAssertGreaterThan(timer.totalTime, 1.9)
                timer.stop("stop")
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
