//
//  ContentView.swift
//  EOTimer
//
//  Created by Maximilian Zimmermann on 23.01.23.
//

import AVFoundation
import SwiftUI

struct SettingsView: View {
    @State private var selectedTimeMinutes = 3
    @State private var selectedTimeSeconds = 0
    @State private var selectedReminderSeconds = 15
    @State private var reminderIsOn = false
    @State private var beeperIsOn = false
    @State private var offset = CGSize.zero
    @State private var timeViewIsActive = false
    @State var player: AVAudioPlayer?
    
    init() {
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                TitleView()
                
                Spacer()
                
                TimePicker(selectedTimeMinutes: $selectedTimeMinutes, selectedTimeSeconds: $selectedTimeSeconds)

                Spacer()
                
                
                HStack {
                    Spacer().frame(width: 20)
                    Images.reminderIcon.renderingMode(.template).foregroundColor(Colors.black)                                    .frame(width: 26, height: 42)
                    
                    Spacer().frame(width: 20)
                    
                    VStack(alignment: .leading) {
                        Spacer()
                        Text("Attention")
                            .font(.title2)
                            .lineLimit(1)
                            .fontWeight(Font.Weight.medium)
                            .foregroundColor(Colors.black)
                        Text("Alert before end")
                            .font(.footnote)
                            .lineLimit(2)
                            .foregroundColor(Colors.black)
                        
                        Spacer()
                    }
                    .frame(width: UIScreen.screenWidth > 410 ? 130 : 95 )
                    
                    Spacer().frame(width: 16)
                    
                    if reminderIsOn {
                        Picker("Reminder", selection: $selectedReminderSeconds) {
                            let totalTimeInSeconds = selectedTimeSeconds + selectedTimeMinutes * 60
                            ForEach(stride(from: 15, to:  totalTimeInSeconds < 90 ? totalTimeInSeconds : 91, by: 15).map{$0} , id: \.self) {
                                Text(String($0))
                                    .font(.title)
                                    .foregroundColor(reminderIsOn ? Colors.black : Colors.white)
                            }
                        }
                        .frame(width: 50)
                        .pickerStyle(.wheel)
                        
                        if UIScreen.screenWidth > 390 {
                            Text("Sec.").font(.title2).lineLimit(1).foregroundColor(reminderIsOn ? Colors.black : Colors.white)
                            
                        }
                        
                    }
                    
                    Spacer()
                    
                    Toggle("", isOn: $reminderIsOn)
                        .tint(Colors.lightBlue)
                        .onChange(of: reminderIsOn) { newValue in
                            if newValue {
                                playSound(soundName: Strings.sound_metronome)
                            }
                        }
                    Spacer().frame(width: 8)
                    
                    
                }
                .background(Colors.white)
                .cornerRadius(10)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .shadow(radius: 10)
                .frame(height: 150)
                
                Spacer()
                
                HStack {
                    Spacer().frame(width: 16)
                    Images.beeperIcon
                        .renderingMode(.template)
                        .foregroundColor(Colors.black)
                        .frame(width: 38, height: 32)
                    
                    Spacer().frame(width: 8)
                    
                    VStack(alignment: .leading) {
                        Spacer()
                        
                        Text("Shut up")
                            .font(.title2)
                            .lineLimit(1)
                            .fontWeight(Font.Weight.medium)
                            .foregroundColor(Colors.black)
                        
                        Text("Alert after end")
                            .font(.footnote)
                            .foregroundColor(Colors.black)
                        
                        Spacer()
                    }
                    .frame(width: UIScreen.screenWidth > 410 ? 150 : 95 )
                    Spacer()
                    Toggle("", isOn: $beeperIsOn)
                        .tint(Colors.red)
                        .onChange(of: beeperIsOn) { newValue in
                            if newValue {
                                playSound(soundName: Strings.sound_metronome)
                            }
                        }
                    Spacer().frame(width: 8)
                }
                .background(Colors.white)
                .cornerRadius(10)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .shadow(radius: 10)
                .frame(height: 150)
                
                Spacer()
                NavigationLink(destination: TimerView(startingTimeInSeconds: currentTimeInSeconds(), reminderTimeInSeconds: reminderIsOn ? (currentTimeInSeconds() > selectedReminderSeconds ? selectedReminderSeconds : 15) : currentTimeInSeconds() > 15 ? 15 : 0, beeperIsOn: beeperIsOn, reminderIsOn: currentTimeInSeconds() > 15 ? reminderIsOn : false)) {
                    ZStack {
                        Circle()
                            .frame(maxWidth: 80, alignment: .center)
                            .foregroundColor(Colors.white)
                        Images.playIcon
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(beeperIsOn ? Colors.red : reminderIsOn ? Colors.lightBlue : Colors.darkBlue)
                            .frame(width: 33, height: 38)
                            .padding(EdgeInsets(top: 0, leading: 8 , bottom: 0, trailing: 0))
                    }
                }
                
                Text("Start").font(.title).foregroundColor(Colors.white)
            }
            
            
            .background(beeperIsOn ? Colors.red : reminderIsOn ? Colors.lightBlue : Colors.darkBlue)
        }
        .preferredColorScheme(.dark)
        .navigationViewStyle(StackNavigationViewStyle())
        .tint(Colors.white)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if offset.width < -200 {
                        self.timeViewIsActive = true
                    } else {
                        offset = .zero
                    }
                }
        )
    }
    
    func currentTimeInSeconds() -> Int {
        let totalTimeInSeconds = selectedTimeMinutes * 60 + selectedTimeSeconds
        return totalTimeInSeconds > 0 ? totalTimeInSeconds : 15
    }
    
    func playSound(soundName: String) {
        guard let path = Bundle.main.path(forResource: soundName, ofType: "mp3") else { return }
        let url = URL(fileURLWithPath: path)
        player = try? AVAudioPlayer(contentsOf: url)
        player?.play()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
