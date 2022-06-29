//
//  LineGraph.swift
//  CryptoBase
//
//  Created by MEP LAB 01 on 10/05/22.
//

import Foundation
import SwiftUI

struct LineGraph : Shape {
    var yValues: [Double]
    let upperValue: Double
    let lowerValue: Double
    
    func path(in rect: CGRect) -> Path {
        let xIncrement = (Double(rect.width) / Double((yValues.count) - 1))
        var path = Path()
        
        guard yValues.count > 0 else {
            return path
        }
        path.move(to: CGPoint(x: 0, y: Double(rect.height) -  ((yValues[0] - lowerValue) * (Double(rect.height) / (upperValue - lowerValue)))))
        
        for i in 1..<yValues.count {
            let pt = CGPoint(x: Double(i) * xIncrement , y: Double(rect.height) -  ((yValues[i] - lowerValue) * (Double(rect.height) / (upperValue - lowerValue))))
            path.addLine(to: pt)
        }
        return path
    }
    

}
