//
//  ContentView.swift
//  iOSFamilyHub
//
//  Created by Johnny on 5/9/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = PostViewModel()
    @ObservedObject var appViewModel = ApplicationViewModel.main
    
    
    var body: some View {
        NavigationView {
            if !appViewModel.isUserLoggedIn {
                LoginPage()
            }
            else {
                TabView {
                    HomePageView(viewModel: viewModel)
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                    
                    ShareView(viewModel: viewModel)
                        .tabItem {
                            Image(systemName: "square.and.arrow.up")
                            Text("Share")
                        }
                    
                    Text("Events Coming Soon")
                        .tabItem {
                            Image(systemName: "bell.fill")
                            Text("Events")
                        }
                    
                    SettingsView(appViewModel: appViewModel)
                        .tabItem {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                }
           }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
