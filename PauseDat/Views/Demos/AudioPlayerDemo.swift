//
//  AudioPlayerDemo.swift
//  PauseDat
//
//  Created by Ebad Rehman on 9/29/26.
//

import SwiftUI

struct AudioPlayerDemo: View {
    
    var AudioPlayer = PomodoroAudio()
    var body: some View {
        VStack{
            Button("Play done"){
                AudioPlayer.play(PomodoroAudioSounds.done)
            }
            Button("Play tick"){
                AudioPlayer.play(PomodoroAudioSounds.tick)
            }
        }
    }
}

#Preview {
    AudioPlayerDemo()
}
