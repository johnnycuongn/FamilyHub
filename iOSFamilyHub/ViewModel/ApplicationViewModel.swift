//
//  ApplicationViewModel.swift
//  iOSFamilyHub
//
//  Created by Johnny on 6/9/2023.
//

import Foundation

// This is ApplicationViewModel. Using for

protocol ApplicationViewModelInterface: ObservableObject {
    
}

class ApplicationViewModel: ObservableObject {
    @Published var user: String = ""
    
    @Published var isUserLoggedIn: Bool = false
    
    static let main = ApplicationViewModel()
    
    /// Log in user with username
    public func signIn(username: String) {
        self.user = username
        self.isUserLoggedIn = true
    }
    
    public func logout() {
        self.user = ""
        self.isUserLoggedIn = false
    }
    
    public func isUserAvailable() -> Bool {
        return self.user != ""
    }
    
}
