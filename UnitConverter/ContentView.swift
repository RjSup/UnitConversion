//
//  ContentView.swift
//  UnitConverter
//
//  Created by Ryan on 14/08/2025.
//

import SwiftUI
import Foundation

struct ContentView: View {
    let units: [UnitLength] = [.meters, .kilometers, .centimeters, .millimeters, .inches, .feet]
    
    @State private var firstMetric: UnitLength = .meters
    @State private var firstValue: Double? = nil
    @State private var secondMetric: UnitLength = .centimeters
    @State private var resultText: String = ""
    
    // Computed property for conversion
    var convertedValue: Double {
        guard let value = firstValue else { return 0 }
        let measurement = Measurement(value: value, unit: firstMetric)
        return measurement.converted(to: secondMetric).value
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    // Input section
                    Section(header: Text("Enter amount to convert").bold()) {
                        TextField("Required", value: $firstValue, format: .number)
                            .keyboardType(.decimalPad)
                    }
                    
                    // Pickers section
                    Section(header: Text("Select units").bold()) {
                        Picker("From:", selection: $firstMetric) {
                            ForEach(units, id: \.self) { unit in
                                Text(unit.symbol.capitalized).tag(unit)
                            }
                        }
                        Picker("To:", selection: $secondMetric) {
                            ForEach(units, id: \.self) { unit in
                                Text(unit.symbol.capitalized).tag(unit)
                            }
                        }
                    }
                    
                    // Result section
                    Section {
                        Button("Calculate") {
                            resultText = "\(convertedValue.formatted()) \(secondMetric.symbol)"
                        }
                        
                        if !resultText.isEmpty {
                            Text(resultText)
                                .font(.headline)
                        }
                    }
                }
                .navigationTitle("Converter")
            }
        }
    }
}

#Preview {
    ContentView()
}

