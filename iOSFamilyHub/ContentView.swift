//
//  ContentView.swift
//  iOSFamilyHub
//
//  Created by Johnny on 5/9/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = PostViewModel()
    @ObservedObject var eventsViewModel = EventViewModel()
    @ObservedObject var appViewModel = ApplicationViewModel.main
    
    
    var body: some View {
        NavigationView {
            // If no user is presented, display a login page
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
                    
                    EventsView(viewModel: eventsViewModel)
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
