//
//  ContentView.swift
//  BetterRest
//
//  Created by Fauzan Dwi Prasetyo on 02/06/23.
//

import CoreML
import SwiftUI

struct ContentView: View {
    init() {
           //Use this if NavigationBarTitle is with Large Font
           UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

           //Use this if NavigationBarTitle is with displayMode = .inline
           UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
       }
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 5
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    // wake up
                    Section {
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(.wheel)
                    } header: {
                        Text("When you want to wake up?")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    
                    // sleep
                    Section {
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    } header: {
                        Text("Desired amount of sleep")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    
                    // coffee
                    Section {
                        Picker(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", selection: $coffeeAmount) {
                            ForEach(0..<21) {
                                Text("\($0)")
                            }
                        }
                        
                        
                    } header: {
                        Text("Daily coffe intake")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    
                    // result
                    Section {
                        HStack {
                            Text("\(calculatedBedTime)")
                                .font(.title.bold())
                                .hCenter()
                        }
                    } header: {
                        HStack {
                            Text("Ideal Bedtime")
                                .font(.headline)
                                .foregroundColor(.white)
                            .hCenter()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.gray)
                .navigationTitle("BetterRest")
            }
        }
    }
    
    var calculatedBedTime: String {
        var result: String
        
        do {
            let configuration = MLModelConfiguration()
            let model = try SleepCalculator(configuration: configuration)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: Double(sleepAmount), coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            result = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            result = "Sorry, there was a problem calculating your bedtime."
        }
        
        return result
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func hCenter() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
}
