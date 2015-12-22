//
//  AccountControllerTests.swift
//  JustGivingKit
//
//  Created by Matthew Cheetham on 22/12/2015.
//  Copyright © 2015 3 Sided Cube. All rights reserved.
//

import XCTest
import JustGivingKit

class AccountControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreatesAccountControllerSuccessfully() {
        
        let accountController = AccountController()
        
        XCTAssertNotNil(accountController, "Account controller was not initialised")
        
    }
    
}
