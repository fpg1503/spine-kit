//
//  BezierCurve.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

//Based on https://opensource.apple.com/source/WebCore/WebCore-955.66/platform/graphics/UnitBezier.h


//TODO think how to remove this state from here
struct BezierCurveSampleData {
   let pointA: (x: Double, y: Double)
   let pointB: (x: Double, y: Double)
    let duration: Double
}

class Bezier {
    
    private var cx: Double
    private var bx: Double
    private var ax: Double
    private var cy: Double
    private var by: Double
    private var ay: Double
    
    private var pointA: (x: Double, y: Double)? = nil
    private var pointB: (x: Double, y: Double)? = nil
    private var duration: Double? = nil
    private var hasCurveData: Bool = false
    
    init(control1: (x: Double, y: Double), control2: (x: Double, y: Double)) {
        self.cx = 3.0 * control1.x
        self.bx = 3.0 * control2.x - control1.x - self.cx
        self.ax = 1.0 - self.cx - self.bx

        self.cy = 3.0 * control1.y
        self.by = 3.0 * control2.y - control1.y - self.cy
        self.ay = 1.0 - self.cy - self.by
    }    

    func solve(elapsedTime: Double, curveSampleDataBlock: () -> BezierCurveSampleData) -> (x: Double, y: Double)  {
        
        if !self.hasCurveData {
            let data = curveSampleDataBlock()
            self.pointA = data.pointA
            self.pointB = data.pointB
            self.duration = data.duration
            self.hasCurveData = true
        }
        
        return solve(elapsedTime)
    }
    
    private func solve(elapsedTime: Double) -> (x: Double, y: Double) {
        
        var result: (x: Double, y: Double) = (x: 0, y: 0)
        
        if let pointA = self.pointA, let pointB = self.pointB, let duration = self.duration {
        
            let epsilon = (1000 / 60 / (duration * 1000)) / 4
            let bezierPoint = self.solve(elapsedTime / duration, epsilon:epsilon)
            result = (x: pointA.x * (1 - bezierPoint) + (pointB.x * bezierPoint), y: pointA.y * (1 - bezierPoint) + (pointB.y * bezierPoint));
            
        }
        return result
    }

    private func solve(x: Double, epsilon: Double) -> Double {
        return self.sampleCurveY(self.solveCurveX(x, epsilon:epsilon));
    }
    
    private func sampleCurveX(t : Double) -> Double {
        // `ax t^3 + bx t^2 + cx t' expanded using Horner's rule.
        return ((self.ax * t + self.bx) * t + self.cx) * t;
    }
    
    private func sampleCurveY(t: Double) -> Double {
        return ((self.ay * t + self.by) * t + self.cy) * t;
    }
    
    private func sampleCurveDerivativeX(t: Double) -> Double {
        return (3.0 * self.ax * t + 2.0 * self.bx) * t + self.cx;
    }
    
    // Given an x value, find a parametric value it came from.
    private func solveCurveX(x: Double, epsilon: Double) -> Double {

        var t0: Double
        var t1: Double
        var t2: Double
        var x2: Double
        var d2: Double
        var i: Int
    
        // First try a few iterations of Newton's method -- normally very fast.
        for t2 = x, i = 0; i < 8; i++ {
          
            x2 = self.sampleCurveX(t2) - x
            
            if abs(x2) < epsilon {
                return t2
            }

            d2 = self.sampleCurveDerivativeX(t2);
            
            if abs(d2) < 1e-6 {
                break
            }
            t2 = t2 - x2 / d2;
        }
        
        // Fall back to the bisection method for reliability.
        t0 = 0.0;
        t1 = 1.0;
        t2 = x;
        
        if t2 < t0 {
            return t0
        }
        if (t2 > t1) {
            return t1
        }
    
        while (t0 < t1) {
            x2 = self.sampleCurveX(t2)
            if (abs(x2 - x) < epsilon) {
                return t2
            }
            if (x > x2) {
                t0 = t2
            } else {
                t1 = t2
            }
            t2 = (t1 - t0) * 0.5 + t0;
        }
    
        return t2
    }
    
    
}