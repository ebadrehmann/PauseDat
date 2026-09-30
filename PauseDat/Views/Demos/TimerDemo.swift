//
//  TimerDemo.swift
//  PauseDat
//
//  Created by Ebad Rehman on 9/30/26.
//

import SwiftUI

struct TimerDemo: View {
    private var timer: PomodoroTimer = PomodoroTimer(workInSeconds: 10, breakInSeconds: 5)
    var body: some View {
        Text("\(timer.secondsLeft)")
        Text("\(timer.secondsLeftString)")
        Text("\(timer.mode.rawValue)")
        
        if timer.state == .idle{
            Button("Start timer"){
                timer.start()
            }
        }
        
        if timer.state == .running{
            Button("Pause timer"){
                timer.pause()
            }
        }
        
        if timer.state == .paused{
            Button("Resume timer"){
                timer.resume()
            }
        }
    }
}

#Preview {
    TimerDemo()
}
