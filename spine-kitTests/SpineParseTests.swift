//
//  SpineParseTests.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/19/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import XCTest

class SpineParseTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    func test() {
        let parse = SpineParse()
        let json = FileHelper.loadTextFile("dragon", type: "json", subpath: "dragon")
        let parsedModel = parse.parse("dragon", data: json!)
        
        XCTAssertTrue(parsedModel?.slots?.count > 0)
        XCTAssertTrue(parsedModel?.bones?.count > 0)
        XCTAssertTrue(parsedModel?.skins?.count > 0)
        XCTAssertTrue(parsedModel?.animations?.count > 0)
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
