//
//  NewEventView.swift
//  iOSFamilyHub
//
//  Created by Johnny on 13/9/2023.
//

import SwiftUI

struct NewEventView: View {
    
    @ObservedObject var viewModel: EventViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
           
           if errorText != "" {
               Text(errorText).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading).padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.red, lineWidth: 1))
           }
           
           Button(action: {
               // Logic to add the new event
               addEvent()
           }) {
               HStack(spacing: 5) {
                   if isLoading {
                       ProgressView()
                   }
                   else {
                       Image(systemName: "plus")
                           .foregroundColor(.white)
                   }
                   Text("Create Event")
                       .fontWeight(.semibold)
               }
           }
           .frame(maxWidth: .infinity)
           .padding()
           .background(isLoading ? .gray : .blue)
           .foregroundColor(.white)
           .cornerRadius(8)
           .disabled(isLoading)
           .alert(isPresented: $showSuccessAlert) {
               Alert(title: Text("Event Created!"), message: Text("A new event has been shared."), dismissButton: .default(Text("OK")))
           }
           
       }.padding([.leading, .trailing], 20)
    }
    
    func addEvent() {
        errorText = ""
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            do {
                defer { isLoading = false }
                try viewModel.addEvent(title: title, date: date, location: location, organiser: organiser, members: members.split(separator: ",").map { String($0) }, description: description)
                showSuccessAlert = true
                
                // Return to previous page
                self.presentationMode.wrappedValue.dismiss()
                
            } catch EventsViewModelError.invalidTitle {
                errorText = "Invalid Title"
            } catch EventsViewModelError.invalidLocation {
                errorText = "Invalid Location"
            } catch EventsViewModelError.invalidDescription {
                errorText = "Invalid Description"
            } catch {
                errorText = error.localizedDescription
            }
            
            self.title = ""
            self.date = Date()
            self.organiser = ""
            self.description = ""
            self.location = ""
            self.members = ""
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
