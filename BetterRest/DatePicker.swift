//
//  DatePicker.swift
//  BetterRest
//
//  Created by Fauzan Dwi Prasetyo on 03/06/23.
//

import SwiftUI

struct DatePickerView: View {
    @State private var wakeUp = Date.now
    
    var body: some View {
        DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)
            .labelsHidden()
    }
    
    func exampleDates() {
        let tomorrow = Date.now.addingTimeInterval(86400)
        let range = Date.now...tomorrow
        print(range)
    }
}

struct DatePickerViews_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView()
    }
}
