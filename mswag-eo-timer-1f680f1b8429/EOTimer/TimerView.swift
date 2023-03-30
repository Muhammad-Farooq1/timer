//
//  Timer.swift
//  EOTimer
//
//  Created by Maximilian Zimmermann on 23.01.23.
//

import AVFoundation
import CoreMotion
import SwiftUI

struct TimerView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var reminderIsOn: Bool
    @State var restTimeInSeconds: Double
    @State var restTimeInSecondsWithAnimation: Double
    @State var timeIsRunning = true
    @State var beeperIsOn: Bool
    @State var player: AVAudioPlayer?
    
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    
    @State private var rotation = Double.zero
    @State private var isLocked = false
    
    var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    let startTimeInSeconds: Int
    var reminderTimeInSeconds: Int = 30
    
    init (startingTimeInSeconds: Int, reminderTimeInSeconds: Int, beeperIsOn: Bool, reminderIsOn: Bool) {
        UIApplication.shared.isIdleTimerDisabled = true
        
        self.startTimeInSeconds = startingTimeInSeconds
        _restTimeInSeconds = State(initialValue: Double(startingTimeInSeconds))
        _restTimeInSecondsWithAnimation = State(initialValue: Double(startingTimeInSeconds))
        self.reminderTimeInSeconds = reminderTimeInSeconds
        _beeperIsOn = State(initialValue: beeperIsOn)
        _reminderIsOn = State(initialValue: reminderIsOn)
    }
    
    var backButton : some View { Button(action: {
        timeIsRunning = false
        restTimeInSeconds = Double(startTimeInSeconds)
        restTimeInSecondsWithAnimation = Double(startTimeInSeconds)
        self.presentationMode.wrappedValue.dismiss()
        timer.upstream.connect().cancel()
        player?.stop()
    }) {
        HStack {
            Images.backIcon
            Text("Back")
        }
    }}
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack {
                Button(action: {
                    if restTimeInSeconds > 30 || restTimeInSeconds - Double(reminderTimeInSeconds) > 0 {
                        withAnimation {
                            reminderIsOn.toggle()
                        }
                    }
                }) {
                    ZStack {
                        Circle()
                            .frame(maxWidth: 80, alignment: .center)
                            .foregroundColor(reminderIsOn && restTimeInSeconds > Double(reminderTimeInSeconds) ? Colors.white : Colors.white.opacity(0.2))
                        Images.reminderIcon
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Colors.black)
                            .frame(width: 26, height: 42)
                    }
                    .rotationEffect(Angle(radians: CGFloat(rotation)))
                }
                Spacer().frame(width: 48)
                
                Button(action: {
                    withAnimation {
                        beeperIsOn.toggle()
                    }
                }) {
                    ZStack {
                        Circle()
                            .frame(maxWidth: 80, alignment: .center)
                            .foregroundColor(beeperIsOn ? Colors.white : Colors.white.opacity(0.2))
                        Images.beeperIcon
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Colors.black)
                            .frame(width: 38, height: 48)
                            .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
                    }
                    .rotationEffect(Angle(radians: CGFloat(rotation)))
                }
            }
            
            Spacer()
            
            ZStack {
                Circle()
                    .stroke(Colors.white.opacity(0.2), style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .foregroundColor(Color.black.opacity(0))
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                if beeperIsOn && restTimeInSeconds > 0 {
                    Circle()
                        .trim(from: 0.5, to: 0.75)
                        .stroke(LinearGradient(colors: [Colors.red,Colors.red.opacity(0)], startPoint: .top, endPoint: .center), style: StrokeStyle(lineWidth: 15, lineCap: .round))
                        .foregroundColor(Color.black.opacity(0))
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    
                    
                    
                }
                
                Circle()
                    .trim(from: 0, to: CGFloat(restTimeInSecondsWithAnimation) / CGFloat(startTimeInSeconds))
                    .stroke(Colors.white, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .foregroundColor(Color.black.opacity(0))
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                if reminderIsOn {
                    Circle()
                        .trim(from: 0, to: Int(restTimeInSeconds) < reminderTimeInSeconds ? CGFloat(restTimeInSecondsWithAnimation) / CGFloat(startTimeInSeconds) : CGFloat(reminderTimeInSeconds) / CGFloat(startTimeInSeconds))
                        .stroke(restTimeInSeconds > Double(reminderTimeInSeconds) ? Colors.lightBlue : Colors.white, style: StrokeStyle(lineWidth: 16, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .foregroundColor(Color.black.opacity(0))
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
                
                Text(generateStringFormatFromSeconds(Int(restTimeInSeconds)))
                    .foregroundColor(.white)
                    .opacity(restTimeInSeconds < 0 ? 0.5 : 1)
                    .onReceive(timer) { _ in
                        checkForAnimationAndSound()
                    }
                    .font(.system(size: restTimeInSeconds < -999 ? 50 : restTimeInSeconds < -99 ? 80 : restTimeInSeconds < 60 ? 180 : 120, weight: .medium, design: .default))
            }
            .rotationEffect(Angle(radians: CGFloat(rotation)))
            
            Spacer()
            
            HStack {
                Button(action: {
                    restTimeInSeconds = Double(startTimeInSeconds)
                    withAnimation {
                        restTimeInSecondsWithAnimation = Double(startTimeInSeconds)
                    }
                    
                    if restTimeInSeconds < 0 {
                        timeIsRunning = true
                    }
                }) {
                    ZStack {
                        Circle()
                            .frame(maxWidth: 80, alignment: .center)
                            .foregroundColor(Colors.white)
                        Images.replayIcon
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Colors.black)
                            .frame(width: 40, height: 35)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4))
                        
                    }
                    .rotationEffect(Angle(radians: CGFloat(rotation)))
                }
                
                Spacer().frame(width: 48)
                
                Button(action: {
                    if restTimeInSeconds > 0 || timeIsRunning {
                        timeIsRunning.toggle()
                    }
                }) {
                    ZStack {
                        Circle()
                            .frame(maxWidth: 80, alignment: .center)
                            .foregroundColor(Colors.white)
                        (restTimeInSeconds < 0 ? Images.stopIcon : timeIsRunning ? Images.pauseIcon : Images.playIcon)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Colors.black)
                            .frame(width: 33, height: restTimeInSeconds < 0 ? 33 : 38)
                            .padding(EdgeInsets(top: 0, leading: !timeIsRunning && restTimeInSeconds > 0 ? 8 : 0, bottom: 0, trailing: 0))
                    }
                    .rotationEffect(Angle(radians: CGFloat(rotation)))
                }
            }
            .padding()
        }
        .background {
            (restTimeInSeconds < 0 ? Colors.red : reminderIsOn && restTimeInSeconds < Double(reminderTimeInSeconds) ? Colors.lightBlue : Colors.darkBlue )
                .edgesIgnoringSafeArea(.all)
                .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .onAppear {
            print("ON APPEAR")
            self.motionManager.startDeviceMotionUpdates(to: self.queue) { (data: CMDeviceMotion?, error: Error?) in
                guard let data = data else {
                    print("Error: \(error!)")
                    return
                }
                
                let gravity = data.gravity
                
                let newRotation = atan2(gravity.x, gravity.y) - Double.pi
                
                if abs(gravity.x) < 0.3 && abs(gravity.y) < 0.3 {
                    if !isLocked {
                        isLocked.toggle()
                        if newRotation < -1 * Double.pi {
                            withAnimation {
                                rotation = -2 *  Double.pi
                            }
                        } else {
                            withAnimation {
                                rotation = 0
                            }
                        }
                    }
                    
                    
                } else {
                    if isLocked {
                        isLocked.toggle()
                        
                        if newRotation < -1 * Double.pi {
                            rotation = -2 *  Double.pi
                        } else {
                            rotation = 0
                        }
                        
                        withAnimation {
                            rotation = newRotation
                        }
                        
                    } else {
                        rotation = newRotation
                    }
                }
                
                print(rotation)
                print("X \(gravity.x)")
                print("Y \(gravity.y)")
            }
        }
    }
    
    func generateStringFormatFromSeconds(_ time: Int) -> String {
        if time < 0 { return String(time) }
        
        let minutes = (time % 3600) / 60
        let seconds = (time % 3600) % 60
        
        if minutes == 0 {
            return String(seconds)
        } else if minutes >= 10 {
            if seconds >= 10 {
                return "\(minutes):\(seconds)"
            } else {
                return "\(minutes):0\(seconds)"
            }
        } else if seconds >= 10 {
            return "\(minutes):\(seconds)"
        } else {
            return "\(minutes):0\(seconds)"
        }
    }
    
    func checkForAnimationAndSound() {
        if timeIsRunning {
            restTimeInSeconds -= 0.1
            
            withAnimation {
                restTimeInSecondsWithAnimation -= 0.1
            }
            
            let restTimeRounded = (restTimeInSeconds * 10).rounded() / 10
            
            try? AVAudioSession.sharedInstance().setCategory(.playback)
            
            if reminderIsOn && (restTimeInSeconds * 10).rounded() / 10 == Double(reminderTimeInSeconds) {
                playSound(soundName: Strings.sound_metronome)
            } else if restTimeRounded > -0.05 && restTimeRounded < 0.05  {
                playSound(soundName: Strings.sound_metronome)
            } else if beeperIsOn && restTimeRounded < -0.5 &&  restTimeRounded.truncatingRemainder(dividingBy: 5) > -0.15 && restTimeRounded.truncatingRemainder(dividingBy: 5) < -0.05 {
                playSound(soundName: Strings.sound_metronome)
            }
        }
    }
    
    func playSound(soundName: String) {
        guard let path = Bundle.main.path(forResource: soundName, ofType: "mp3") else { return }
        let url = URL(fileURLWithPath: path)
        player = try? AVAudioPlayer(contentsOf: url)
        player?.play()
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(startingTimeInSeconds: 5000, reminderTimeInSeconds: 3, beeperIsOn: true, reminderIsOn: true)
    }
}

private let gradient = AngularGradient(
    gradient: Gradient(colors: [Colors.red, Colors.red.opacity(0)]),
    center: .center,
    startAngle: .degrees(0),
    endAngle: .degrees(90))


class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    @Published var x = 0.0
    @Published var y = 0.0
    
    init() {
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
            
            guard let motion = data?.attitude else { return }
            self?.x = motion.roll
            self?.y = motion.pitch
        }
    }
}
