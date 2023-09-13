//
//  EventsView.swift
//  iOSFamilyHub
//
//  Created by Johnny on 13/9/2023.
//

import SwiftUI

struct EventCardView<DisplayableContent: DisplayableEventInterface>: View {
    @Binding var event: DisplayableContent

    var body: some View {
        
            CardView {
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.gray)
                    Text(event.organiser)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                // Description
                Text(event.description)
                    .font(.headline)
                    .padding(.top, 10)
//
//
//                // Author and Date
//                HStack {
//                    Image(systemName: "location")
//                        .foregroundColor(.gray)
//                    Text(post.location)
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//
//
//                    Spacer()
//
//                    Image(systemName: "calendar")
//                        .foregroundColor(.gray)
//                    Text(post.date.formatted(.dateTime))
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                }.padding(.top, 5)
            }
    }
}

struct EventsView: View {
    @ObservedObject var viewModel: EventViewModel
    @ObservedObject var appViewModel = ApplicationViewModel.main
    
    // Load image from system path
    
    var body: some View {
        NavigationView {
            ScrollView {
                NavigationLink(destination: NewEventView(viewModel: self.viewModel)) {
                    ActionButton(title: "Add") {}
                }
                
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                LazyVStack {
                   ForEach(viewModel.events.indices, id: \.self) { i in
                       EventCardView(event: $viewModel.events[i])
                   }
                }
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
