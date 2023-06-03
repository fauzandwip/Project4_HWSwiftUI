//
//  Stepper.swift
//  BetterRest
//
//  Created by Fauzan Dwi Prasetyo on 02/06/23.
//

import SwiftUI


// MARK: - Stepper

struct StepperView: View {
    @State private var sleepAmount = 8.0
    var body: some View {
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
    }
}

//struct StepperView_Previews: PreviewProvider {
//    static var previews: some View {
//        StepperView()
//    }
//}
