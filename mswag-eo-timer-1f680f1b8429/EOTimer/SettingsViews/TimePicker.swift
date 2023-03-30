//
//  TimePicker.swift
//  EOTimer
//
//  Created by Maximilian Zimmermann on 21.03.23.
//

import SwiftUI

struct TimePicker: View {
    @Binding var selectedTimeMinutes: Int
    @Binding var selectedTimeSeconds: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Picker("Timer", selection: $selectedTimeMinutes) {
                    ForEach(Numbers.timeStepsMinutesAlarm, id: \.self) {
                        Text(String($0))
                            .foregroundColor(Colors.black)
                            .font(.title)
                    }
                }
                .pickerStyle(.wheel)
                
                Text("Min.")
                    .foregroundColor(Colors.black)
                    .font(.title2)
                
                
                Picker("Timer", selection: $selectedTimeSeconds) {
                    ForEach(selectedTimeMinutes == 0 ? Numbers.timeStepsSecondsAlarm0Minutes : Numbers.timeStepsSecondsAlarm, id: \.self) {
                        Text(String($0))
                            .foregroundColor(Colors.black)
                            .font(.title)
                    }
                }
                .pickerStyle(.wheel)
                
                Text("Sec.")
                    .foregroundColor(Colors.black)
                    .font(.title2)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
            }
            .background(Colors.white)
            .cornerRadius(10)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .shadow(radius: 10)
            .frame(height: 150)
        }
        
    }
}

