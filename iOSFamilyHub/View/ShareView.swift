//
//  ShareView.swift
//  iOSFamilyHub
//
//  Created by Johnny on 6/9/2023.
//

import SwiftUI

struct ShareView: View {
    
    @ObservedObject var appViewModel = ApplicationViewModel.main
    @ObservedObject var viewModel: PostViewModel
    @State private var image: UIImage?
    @State private var description: String = ""
    @State private var location: String = ""
    private var author: String {return self.appViewModel.user}
    
    @State private var isLoading: Bool = false // For any loading state
    @State private var showSuccessAlert = false // State of Showing success alert
    
    @State private var errorText = "" // Error text for the view

    
    var body: some View {
        VStack {
            Spacer()  // Pushes the content below to the center
            
            TextField("Description", text: $description)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            Text("What & How are you doing?").font(.caption).foregroundColor(.gray).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom)
            
            TextField("Location", text: $location)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            
            (Text("Where are you at? In Sydney or New york?")).font(.caption).foregroundColor(.gray).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom)
            
            Spacer()  // Pushes the content above to the center
            
            if errorText != "" {
                Text(errorText).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading).padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.red, lineWidth: 1))
            }
            
            HStack {
                Image(systemName: "person")
                Text("Shared under").foregroundColor(.gray)
                Text(appViewModel.user).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading).foregroundColor(.gray)
            }
            
            Button(action: {
                sharePost()
            }) {
                HStack(spacing: 5) {
                    if isLoading {
                        ProgressView()
                    }
                    else {
                        Image(systemName: "paperplane")
                            .foregroundColor(.white)
                    }
                    Text("Share")
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
                Alert(title: Text("Shared!"), message: Text("Your post has been shared."), dismissButton: .default(Text("OK")))
            }
            
        }.padding([.leading, .trailing], 20)
    }
    
    func sharePost() {
        errorText = ""
        isLoading = true
        
        // Delay process to stimulate the loading process
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            do {
                defer { isLoading = false }
                try viewModel.addPost(author: author, description: description, location: location, image: nil)
                showSuccessAlert = true
            } catch PostViewModelError.invalidDescription {
                print("Invalid Description")
                errorText = "Empty description. Share more of what you are thinking to your beloved family."
            } catch PostViewModelError.invalidLocation {
                print("Invalid Location")
                errorText = "Where are your at? You don't have to be specific."
            } catch {
                print("An unexpected error occurred: \(error)")
            }
            
            self.description = ""
            self.location = ""
        }
    }
}

struct ShareView_Previews: PreviewProvider {
    
    static var previews: some View {
        let appvm = ApplicationViewModel()
        appvm.signIn(username: "ls")
        
        let vm = PostViewModel()
        
        return ShareView(appViewModel: appvm, viewModel: vm)
    }
}
