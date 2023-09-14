//
//  EventsView.swift
//  iOSFamilyHub
//
//  Created by Johnny on 13/9/2023.
//

import SwiftUI

/// Event Card View for Events Page
struct EventCardView<DisplayableContent: DisplayableEventInterface>: View {
    @Binding var event: DisplayableContent

    var body: some View {
        
            CardView {
                Text(event.title)
                    .font(.title)
                    .padding(.bottom, 2)
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.gray)
                    Text(event.organiser)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 2)
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                    Text(event.date.formatted(.dateTime))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }.padding(.bottom, 2)
                
                HStack {
                    Image(systemName: "location")
                        .foregroundColor(.gray)
                    Text(event.location)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }.padding(.bottom, 2)
                
                HStack {
                    Image(systemName: "person.3")
                        .foregroundColor(.gray)
                    Text(event.members.joined(separator: ",")).foregroundColor(.gray) // Turn array of members into string with commas
                }
                
                // Description
                Text(event.description)
                    .font(.headline)
                    .padding(.top, 10)

            }
    }
}

struct EventsView: View {
    @ObservedObject var viewModel: EventViewModel
    @ObservedObject var appViewModel = ApplicationViewModel.main
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                LazyVStack {
                   ForEach(viewModel.events.indices, id: \.self) { i in
                       EventCardView(event: $viewModel.events[i])
                   }
                }
                NavigationLink(destination: NewEventView(viewModel: self.viewModel)) {
                    CardView {
                        Text("+ Add Event")
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
        }
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = EventViewModel()
        do {
            try vm.addEvent(title: "Event 1", date: Date(), location: "Sydney", organiser: "Cuong", members: ["wd"], description: "Description")
        } catch {
            print(error)
        }
        
        return EventsView(viewModel: vm)
    }
}
