//
//  AtlasBuilderTests.swift
//  spritekit-spine-sdk
//
//  Created by Thiago Medeiros dos Santos on 12/19/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import XCTest

class AtlasBuilderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func test() {
        let parse = SpineParse();
        let json = FileHelper.loadTextFile("example", type: "json")
        let parsedModel = parse.parse("example", data: json!);
        
        let atlasBuilder = AtlasBuilder()
        let atlas = atlasBuilder.load(parsedModel)
        
        XCTAssertNotNil(atlas)
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
