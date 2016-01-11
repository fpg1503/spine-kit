//
//  AtlasBuilderTests.swift
//  spine-kit
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
        let atlas = atlasBuilder.buildFromResources((parsedModel?.name)!)
        
        XCTAssertNotNil(atlas)
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
