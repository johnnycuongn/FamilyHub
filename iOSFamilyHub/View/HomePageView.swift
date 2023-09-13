//
//  HomePageView.swift
//  iOSFamilyHub
//
//  Created by Johnny on 6/9/2023.
//

import SwiftUI
struct PostView<DisplayableContent: DisplayablePostInterface>: View {
    @Binding var post: DisplayableContent

    var body: some View {
        NavigationLink(destination: PostDetailView(post: $post)) {
            CardView {
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.gray)
                    Text(post.author)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                // Description
                Text(post.description)
                    .font(.headline)
                    .padding(.top, 10)

                
                // Author and Date
                HStack {
                    Image(systemName: "location")
                        .foregroundColor(.gray)
                    Text(post.location)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                
                    
                    Spacer()
                    
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                    Text(post.date.formatted(.dateTime))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }.padding(.top, 5)
            }
        }.buttonStyle(PlainButtonStyle())
    }
}


struct HomePageView: View {
    @ObservedObject var viewModel: PostViewModel
    @ObservedObject var appViewModel = ApplicationViewModel.main
    
    // Load image from system path
    
    var body: some View {
        NavigationView {
            ScrollView {
               LazyVStack {
                   ForEach(viewModel.posts.indices, id: \.self) { i in
                       PostView(post: $viewModel.posts[i])
                   }
               }
           }
            .navigationTitle(getCurrentDate())
       
        }
    }
    
    func getCurrentDate() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: currentDate)
    }
    
    
}
struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = PostViewModel()
        do {
            try vm.addPost(author: "2", description: "222222", location: "ASDAS", image: nil)
        } catch {
            print(error)
        }
        return HomePageView(viewModel: vm)
    }
}
