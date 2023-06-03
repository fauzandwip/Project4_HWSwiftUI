//
//  Dates.swift
//  BetterRest
//
//  Created by Fauzan Dwi Prasetyo on 03/06/23.
//

import SwiftUI

struct DatesView: View {
    @State private var components = DateComponents()
    
    var body: some View {
        VStack {
            Button("Tap") {
                dates()
            }
            
            Text(Date.now, format: .dateTime.hour().minute())
            Text(Date.now, format: .dateTime.day().month().year())
            Text(Date.now.formatted(date: .long, time: .shortened))
            Text(Date.now.formatted(date: .long, time: .shortened))
        }
    }
    
    func dates() {
        let date = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
        let hour = date.hour ?? 0
        let minute = date.minute ?? 0
        
        print(hour, minute)
        
    }
}

struct DatesView_Previews: PreviewProvider {
    static var previews: some View {
        DatesView()
    }
}
