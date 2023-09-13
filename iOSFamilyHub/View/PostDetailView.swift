//
//  PostDetailView.swift
//  iOSFamilyHub
//
//  Created by Johnny on 6/9/2023.
//

import SwiftUI

struct PostDetailView<DisplayableContent: DisplayablePostInterface>: View {
    
    @Binding var post : DisplayableContent
    
    var body: some View {
        VStack(alignment: .leading) {
//            Image(uiImage: UIImage(named: post.image) ?? UIImage())
//                .resizable()
//                .aspectRatio(contentMode: .fit)
            Text(post.author).font(.title).fontWeight(.bold)
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.gray)
                Text(post.date.formatted(.dateTime))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(5).background(Color.white)
            .border(Color.gray, width: 0.2)
            .cornerRadius(2)
            .shadow(radius: 4, x: 1)
            
            HStack {
                Image(systemName: "location.circle.fill")
                   .resizable()
                   .scaledToFit()
                   .frame(height: 20)
                   .foregroundColor(.gray)
                Text(post.location).font(.subheadline).foregroundColor(.gray)
            }.foregroundColor(.gray)
            .padding(5)  // Add padding around the text
            .background(Color.white) // Background color of the box
            .border(Color.gray, width: 0.2) // Border around the box
            .cornerRadius(2) // Optional: Rounded corners
            .shadow(radius: 4, x: 1)
            
            Divider().foregroundColor(.black).frame(height: 1)
            Text(post.description).font(.body).frame(maxWidth: .infinity, alignment: .leading)
            // ... other details about the post
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .navigationBarTitle(post.author, displayMode: .inline)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyPost = Post(id: UUID(), author: "John Doe", imagePath: "1", date: Date(), location: "Sydney", description: "Sample Description")
        
        PostDetailView(post: .constant(dummyPost))
    }
}
