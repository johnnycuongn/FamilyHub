//
//  LoginPage.swift
//  iOSFamilyHub
//
//  Created by Johnny on 7/9/2023.
//

import SwiftUI

struct LoginPage: View {
    @ObservedObject var appViewModel = ApplicationViewModel.main
    @State private var showSuccessFeedback: Bool = false
    @State private var showProgress: Bool = false
    
    var currentUserAvailable: Bool {
        return appViewModel.user != ""
    }
    
    /// To check if username is a valid username
    var isUsernameValid: Bool {
           !username.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    @State var username: String = ""
    
    var body: some View {
        VStack {
            if currentUserAvailable {
                Text("Welcome " + appViewModel.user + "!")
            } else {
                TextField("Username", text: $username)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .padding([.leading, .trailing], 20)
            }
            
            if (!currentUserAvailable) {
                Button {
                    // Login user
                    handleLogin()
                } label: {
                    Text("Login")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(showProgress ? Color.gray : (currentUserAvailable ? (Color.blue) : ( isUsernameValid ? Color.blue : Color.gray)))     // Change color based on validity
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding([.leading, .trailing], 20)
                .disabled(currentUserAvailable ? false : ( !isUsernameValid || showProgress)) // When user is signing in, disable when username is not valid or in progress
            }
            
            if showProgress {
               ProgressView()
                   .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                   .scaleEffect(1.5, anchor: .center)
            }
            
            if showSuccessFeedback {
                Text("Login Successful!")
                    .foregroundColor(.green)
            }
          
        }
    }
    
    
    func handleLogin() {
        // Toggle progress on
        showProgress = true

        // Simulate a delay 1 second (such as network request)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Sign user in
            if !username.isEmpty {
                appViewModel.signIn(username: self.username)
                self.username = ""
            }
            
            // Toggle progress off
            self.showProgress = false

            // Show success feedback
            self.showSuccessFeedback = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.showSuccessFeedback = false
            }
        }
    }

}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
