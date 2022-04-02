//
//  ImageContentView.swift
//  Boards
//
//  Created by Dylan Mace on 6/23/21.
//

import SwiftUI
import SDWebImageSwiftUI

let placeholder = UIImage(systemName: "person.circle")

struct ImageContentView : View {
    var content: Post
    @State private var imageURL: URL?
    @EnvironmentObject var viewModel: BoardContentViewModel
    
    init(_ imageContent: Post) {
        content = imageContent
    }
    
    
    
    var body: some View {
        ZStack {
            Color(UIColor.secondarySystemBackground).cornerRadius(10)
            VStack(alignment: .center) {
                HStack {
                    Text(content.title).font(.title).bold()
                    Spacer()
                }
                Divider()
                if let url = imageURL{
                    WebImage(url: url)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(5)
                        .frame(maxWidth: 600)
                } else {
                    ZStack {
                        VStack {
                            Spacer(minLength: 60)
                            Image(systemName: "hourglass")
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(5)
                                .padding()
                                .background( RoundedRectangle(cornerRadius: 5).foregroundColor(content.color))
                        }
                        
                    }
                }
                
            }
            .padding()
            .onAppear {
                self.viewModel.loadImageFromFirebase(urlPath: content.content as! String, completion: { url in
                    withAnimation {
                        self.imageURL = url
                        print(self.imageURL)
                    }
                })
            }
        }
    }
    
    
}
