//
//  CircleButton.swift
//  PauseDat
//
//  Created by Ebad Rehman on 10/1/26.
//

import SwiftUI

struct CircleButton: View {
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
            
        } label: {
            Image(systemName: icon)
                .foregroundColor(Color("Light"))
                .frame(width: 60, height: 60)
                .background(Color("Dark"))
                .clipShape(Circle())
                
            
        }
    }
}

#Preview {
    CircleButton(icon: "play.fill"){
        print("Hello")
    }
}
