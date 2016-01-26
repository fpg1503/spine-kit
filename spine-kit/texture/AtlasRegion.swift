//
//  AtlasRegion.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/26/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

struct AtlasRegion {
    let page: AtlasPage
    let name:String
    let x: Int
    let y: Int
    let width: Int
    let height: Int
    let u: Double
    let v: Double
    let u2: Double
    let v2: Double
    let offsetY: Double
    let offsetX: Double
    let originalHeight: Int
    let originalWidth: Int
    let index: Int
    let rotate: Bool
    let splits: [Int]
    let pads: [Int]
}