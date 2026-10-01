//
//  NotificationDemo.swift
//  PauseDat
//
//  Created by Ebad Rehman on 9/30/26.
//

import SwiftUI

struct NotificationDemo: View {
    @State private var showWarning = false
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        VStack {
            Button("Send notification") {
                PomodoroNotification.scheduleNotification(
                    seconds: 5,
                    title: "This is a test.",
                    body: "Send Message"
                )
            }
            
            if showWarning {
                VStack {
                    Text("Notifications are disabled")
                    
                    Button("Enable") {
                        // must execute in main thread
                        DispatchQueue.main.async{
                            // open settings
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        }
               
                    }
                }
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                PomodoroNotification.checkAuthorization { authorized in
                    showWarning = !authorized
                }
            }
        }
    }
}


#Preview {
    NotificationDemo()
}
