//
//  SettingsView.swift
//  iOSFamilyHub
//
//  Created by Johnny on 6/9/2023.
//

import SwiftUI

struct SettingsView: View {

    // Access to view's presentation mode
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var appViewModel: ApplicationViewModel
    
    var currentUserAvailable: Bool {
        return appViewModel.user != ""
    }
    
    var body: some View {
        VStack {
            if currentUserAvailable {
                Text("Welcome " + appViewModel.user + "!")
            }
            
            Button {
                    // Logout User
                    handleLogout()
            } label: {
                Text("Logout")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding([.leading, .trailing], 20)

          
        }
    }
    
    func handleLogout() {
        appViewModel.logout()
        
        // Dismiss current view
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ApplicationViewModel()
        SettingsView(appViewModel: vm)
    }
}
