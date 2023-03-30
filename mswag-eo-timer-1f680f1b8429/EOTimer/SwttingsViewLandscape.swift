//
//  SwttingsViewLandscape.swift
//  EOTimer
//
//  Created by Maximilian Zimmermann on 30.01.23.
//

import SwiftUI

struct SettingsViewLandscape: View {
    var body: some View {
        HStack {
            VStack {
                Spacer()
                Text("Timer")
                    .font(.title)
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 0))
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                HStack {
                    Picker("Timer", selection: $selectedTimeMinutes) {
                        ForEach(timeStepsMinutes, id: \.self) {
                            Text(String($0))
                                .foregroundColor(Colors.white)
                                .font(.title)
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    Text("Min.")
                        .foregroundColor(Colors.white)
                        .font(.title)
                    
                    
                    Picker("Timer", selection: $selectedTimeSeconds) {
                        ForEach(timeStepsSeconds, id: \.self) {
                            Text(String($0))
                                .foregroundColor(Colors.white)
                                .font(.title)
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    Text("Sec.")
                        .foregroundColor(Colors.white)
                        .font(.title)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                }
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 16))
                .shadow(radius: 10)
                .cornerRadius(10)
                .background(Image("background_blue").resizable())
                Spacer()
            }
            Spacer().frame(width: 8)
            VStack {
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text("Reminder")
                            .font(.title)
                        Text("Alert before end of timer")
                            .font(.footnote)
                    }
                    .frame(width: 150)
                    
                    Spacer()
                    
                    Toggle("", isOn: $reminderIsOn)
                        .tint(Colors.green)
                    
                    Spacer().frame(minWidth: 10)
                    
                    if reminderIsOn {
                        Picker("Reminder", selection: $selectedReminderSeconds) {
                            ForEach(timeStepsSecondsReminder, id: \.self) {
                                Text(String($0))
                                    .font(.title)
                            }
                        }
                        .frame(width: 80)
                        .pickerStyle(.wheel)
                        
                    }
                    
                    
                }
                .frame(height: 120)
                .padding()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Beeper")
                            .font(.title)
                        Text("Annoying sound after end")
                            .font(.footnote)
                    }
                    Spacer()
                    Toggle("", isOn: $beeperIsOn)
                        .tint(Colors.green)
                    
                    Spacer()
                    Spacer()
                    
                    NavigationLink(destination: TimerView(startingTimeInSeconds: currentTimeInSeconds(), reminderTimeInSeconds: reminderIsOn ? selectedReminderSeconds : 0, beeperIsOn: beeperIsOn)) {
                        ZStack {
                            Circle()
                                .frame(maxWidth: 60, alignment: .center)
                                .foregroundColor(Colors.green)
                            Image(Strings.playIcon)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Colors.white)
                                .frame(width: 24, height: 24)
                                .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 0))
                        }
                    }
                }
                .padding()
                
                
            }
        }

    }
}

struct SwttingsViewLandscape_Previews: PreviewProvider {
    static var previews: some View {
        SettingsViewLandscape()
    }
}
