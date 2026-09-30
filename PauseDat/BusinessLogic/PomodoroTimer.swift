//
//  PomodoroTimer.swift
//  PauseDat
//
//  Created by Ebad Rehman on 9/30/26.
//

import Foundation
import Observation

enum PomodoroTimerState: String {
    case idle
    case running
    case paused
}

enum PomodoroTimerMode: String {
    case work
    case pause
}

@Observable
class PomodoroTimer{
    // timer that ticks every second
    
    /*
     Properties:
     * Num of seconds left/passed
     * Fraction 0-1 describes how full the circle is
     * Time remaining as a string (10:42)
     */
    
    /*
     Methods:
     * Play()
     * Pause()
     * Resume()
     * Reset()
     * Skip()
     * helper functions
     */
    
    private var _mode: PomodoroTimerMode = .work
    private var _state: PomodoroTimerState = .idle
    
    private var _durationWork: TimeInterval
    private var _durationBreak: TimeInterval
    
    private var _secondsPassed: Int = 0
    private var _fractionPassed: Double = 0
    private var _dateStarted: Date = Date.now
    private var _secondsPassedBeforePause: Int = 0
    
    private var _timer: Timer?
    private var _audio: PomodoroAudio = PomodoroAudio()
    
    
    init(workInSeconds: TimeInterval, breakInSeconds: TimeInterval){
        _durationWork = workInSeconds
        _durationBreak = breakInSeconds
    }
    
    // computed properties
    private var _duration: TimeInterval{
        if _mode == .work{
            return _durationWork
        }
        else{
            return _durationBreak
        }
    }
    
    var secondsLeft: Int {
        Int(_duration) - _secondsPassed
    }
    
    var secondsPassed: Int {
        return _secondsPassed
    }
    
    var fractionPassed: Double {
        return _fractionPassed
    }
    
    var fractionLeft: Double {
        1.0 - _fractionPassed
    }
    var state: PomodoroTimerState{
        return _state
    }
    
    var mode: PomodoroTimerMode{
        return _mode
    }
    
    var secondsPassedString: String {
        return _formatSeconds(_secondsPassed)
    }
    
    var secondsLeftString: String{
        return _formatSeconds(secondsLeft)
    }
    // public methods
    
    func start(){
        _dateStarted = Date.now
        _secondsPassed = 0
        _fractionPassed = 0
        _state = .running
        _createTimer()
    }
    
    func resume(){
        _dateStarted = Date.now
        _state = .running
        _createTimer()
    }
    
    func pause(){
        _secondsPassedBeforePause = _secondsPassed
        _state = .paused
        _killTimer()
    }
    
    func reset(){
        _secondsPassed = 0
        _fractionPassed = 0
        _secondsPassedBeforePause = 0
        _state = .idle
        _killTimer()
    }
    
    func skip(){
        if self._mode == .work {
            self._mode = .pause
        }else{
            self._mode = .work
        }
    }
    
    
    // private method
    
    private func _createTimer(){
        // schedule notifications
        PomodoroNotification.scheduleNotification(seconds: TimeInterval(secondsLeft), title: "Timer Done", body: "Your pomodoro is complete!")
        // create timer
        _timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){_ in
            self._onTick()
        }
    }
    
    private func _killTimer(){
        _timer?.invalidate()
        _timer = nil
    }
    
    private func _onTick(){
        // calculate seconds since start date
        var secondsSinceStartDate = Date.now.timeIntervalSince(self._dateStarted)
        // add the seconds before paused (if any)
        self._secondsPassed = Int(secondsSinceStartDate) + self._secondsPassedBeforePause
        // calculate fraction
        self._fractionPassed = TimeInterval(self._secondsPassed) / self._duration
        // play tick
        _audio.play(.tick)
        // done? play sound, reset, switch mode, reset timer
        if self.secondsLeft == 0{
            self._fractionPassed = 0
            self.skip() // to switch mode
            self.reset()
            // play ending sound
            _audio.play(.done)
            
        }
    }
    private func _formatSeconds(_ seconds: Int) -> String {
        if seconds <= 0{
            return "00:00"
        }
        let hh: Int = seconds / 3600
        let mm: Int = (seconds % 3600) / 60
        let ss: Int = seconds % 60
        
        if hh > 0 {
            return String(format: "%02d:%02d:%02d", hh, mm, ss)
        }
        else{
            return String(format: "%02d:%02d", mm, ss)
        }
    }
}
