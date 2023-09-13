//
//  ActionButton.swift
//  iOSFamilyHub
//
//  Created by Johnny on 13/9/2023.
//

import SwiftUI

struct ActionButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(8)
        
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(title: "Tap Me!") {
            print("Button tapped!")
        }
        .padding()
    }
}
