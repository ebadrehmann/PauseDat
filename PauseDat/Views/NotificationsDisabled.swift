//
//  NotificationsDisabled.swift
//  PauseDat
//
//  Created by Ebad Rehman on 10/1/26.
//

import SwiftUI

struct NotificationsDisabled: View {
    var body: some View {
        VStack{
            Text("Notifications are disabled").font(.headline)
            Text ("Please enable notifications to be notififed when a pomodoro period is over.").font(.subheadline)
            Button("Open settings"){
                openSettings()
            }.buttonStyle(.bordered)
        }
        .padding()
        .background(Color("Light"))
        .foregroundColor(Color("Dark"))
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .frame(maxWidth: .infinity)
        .padding(.vertical)
    
        
    }
    
    private func openSettings(){
        // must execute in main thread
        DispatchQueue.main.async{
            // open settings
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }
    }
}

#Preview
{
    VStack{
        NotificationsDisabled()
    }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color("Dark"))
}
