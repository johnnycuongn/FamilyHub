//
//  HomePageView.swift
//  iOSFamilyHub
//
//  Created by Johnny on 6/9/2023.
//

import SwiftUI
struct PostView: View {
    @Binding var post: Post

    var body: some View {
        NavigationLink(destination: PostDetailView(post: $post)) {
            VStack(alignment: .leading) {
                
                
                // Description
                Text(post.description)
                    .font(.headline)
                    .padding(.top, 10)
                
                // Location
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.gray)
                    Text(post.author)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }.padding(.top, 5)
                
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
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            .padding([.top, .horizontal])
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
            .navigationTitle("Welcome " + appViewModel.user)
       
        }
    }
    
    
}
struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = PostViewModel()
        vm.addPost(author: "2", description: "222222", location: "ASDAS", image: nil)
        return HomePageView(viewModel: vm)
    }
}
