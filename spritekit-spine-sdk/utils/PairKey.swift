//
//  PairKey.swift
//  spritekit-spine-sdk
//
//  Created by Thiago Medeiros dos Santos on 12/17/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

func ==<A: Hashable, B: Hashable>(pair1: PairKey<A, B>, pair2: PairKey<A, B>) -> Bool {
    return pair1.hashValue == pair2.hashValue
}

class PairKey<A: Hashable, B: Hashable> : Hashable {
    
    var key1: A
    var key2: B
    
    var hashValue : Int {
        get {
            return key1.hashValue ^ key2.hashValue;
        }
    }
    
    init(key1: A, key2: B) {
        self.key1 = key1
        self.key2 = key2
    }
}