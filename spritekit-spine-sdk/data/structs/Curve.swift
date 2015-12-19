//
//  Curve.swift
//  spritekit-spine-sdk
//
//  Created by Thiago Medeiros dos Santos on 12/17/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation


enum Curve {
    case Stepped
    case Undefined
    case Bezier([Float])
}