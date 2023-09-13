//
//  NewEventView.swift
//  iOSFamilyHub
//
//  Created by Johnny on 13/9/2023.
//

import SwiftUI

struct NewEventView: View {
    
    @ObservedObject var viewModel: EventViewModel
    
    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var location: String = ""
    @State private var organiser: String = ""
    @State private var members: String = ""  // For simplicity, treat members as comma-separated strings.
    @State private var description: String = ""
    
    @State private var isLoading: Bool = false
    @State private var showSuccessAlert = false
    
    @State private var errorText = ""

    var body: some View {
       VStack(alignment: .leading) {
           TextField("Title", text: $title)
               .padding()
               .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
           
           DatePicker("Date", selection: $date, displayedComponents: .date)
               .padding()
           
           TextField("Location", text: $location)
               .padding()
               .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
           
           TextField("Organiser", text: $organiser)
               .padding()
               .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
           
           TextField("Members (comma-separated)", text: $members)
               .padding()
               .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
           
           TextField("Description", text: $description)
               .padding()
               .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
           
           Spacer()
           
           Button("Add Event") {
               // Logic to add the new event
           }
           .frame(maxWidth: .infinity)
           .padding()
           .background(Color.blue)
           .foregroundColor(.white)
           .cornerRadius(8)
           
       }.padding([.leading, .trailing], 20)
    }
    
    func addEvent() {
        errorText = ""
        if (description.trimmingCharacters(in: .whitespaces).isEmpty) {
            errorText = "Empty description. Please add a description for your event"
            return
        }
        
        if (location.trimmingCharacters(in: .whitespaces).isEmpty) {
            errorText = "Where are your at? You don't have to be specific."
            return
        }
        showSuccessAlert = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showSuccessAlert = false
            
            do {
//                try viewModel.addPost(author: author, description: description, location: location, image: nil)
            } catch PostViewModelError.invalidDescription {
                print("Invalid Description")
            } catch PostViewModelError.invalidLocation {
                print("Invalid Location")
            } catch {
                print("An unexpected error occurred: \(error)")
            }
            
            self.description = ""
            self.location = ""
        }
    }
}

struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = EventViewModel()
        do {
            try vm.addEvent(title: "1", date: Date(), location: "Sydney", organiser: "Johnny", members: ["1"], description: "Description")
        } catch {
            print(error)
        }
        
        return NewEventView(viewModel: vm)
    }
}
