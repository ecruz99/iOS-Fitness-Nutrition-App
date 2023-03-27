//
//  BMR Calculator.swift
//  Fitness-Nutriton-App
//
//  Created by Erik Cruz on 3/27/23.
//

import SwiftUI

struct BMR_Calculator: View {
    let height: Float = 71
    let weight: Float = 170
    let age: Float = 23
    
    var BMR: Float {
        66.47+(6.24*weight)+(12.7*height)-(6.755*age)
    }
    
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Your height in inches is \(height)")
                .padding()
            Text("Your weight in pounds is \(weight)")
                .padding()
            Text("Your age is \(age)")
                .padding()
            Text("Your Base Metabolic Rate, or calories your body will burn in one day to sustain itself is \(BMR)")
                .padding()
        }
    }
}

struct BMR_Calculator_Previews: PreviewProvider {
    static var previews: some View {
        BMR_Calculator()
    }
}
