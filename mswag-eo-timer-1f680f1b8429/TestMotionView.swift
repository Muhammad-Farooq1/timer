//
//  TestMotionView.swift
//  EOTimer
//
//  Created by Maximilian Zimmermann on 28.02.23.
//

import SwiftUI
import CoreMotion

struct AccelerometerView: View {

    let motionManager = CMMotionManager()
    let queue = OperationQueue()

    @State private var pitch = Double.zero
    @State private var yaw = Double.zero
    @State private var roll = Double.zero

    var body: some View {

        VStack{
            Text("Pitch: \(pitch)")
            Text("Yaw: \(yaw)")
            Text("Roll: \(roll)")
        }//Vstack
        .onAppear {
                print("ON APPEAR")
                self.motionManager.startDeviceMotionUpdates(to: self.queue) { (data: CMDeviceMotion?, error: Error?) in
                    guard let data = data else {
                        print("Error: \(error!)")
                        return
                    }
                    let attitude: CMAttitude = data.attitude

                    print("pitch: \(attitude.pitch)")
                    print("yaw: \(attitude.yaw)")
                    print("roll: \(attitude.roll)")

                    DispatchQueue.main.async {
                        self.pitch = attitude.pitch
                        self.yaw = attitude.yaw
                        self.roll = attitude.roll
                    }
                }
            }//.onappear
    }//view
}//struct
