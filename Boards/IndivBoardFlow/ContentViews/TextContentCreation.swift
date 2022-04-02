//
//  TextContentCreationView.swift
//  Boards
//
//  Created by Dylan Mace on 6/23/21.
//

import SwiftUI

struct TextContentEditView: View {
    @EnvironmentObject var viewModel: BoardContentViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var title: String = ""
    @State var text: String = ""
    @State var color: Color = Color.red
    
//    var id: String
    
    var content: Post
    
    init() {
        content = Post(id: NSUUID().uuidString, title: "", type: .text, color: .primary, timestamp: Date(), content: "")
    }
    
    init(_ post: Post) {
        content = post
    }
    
    
    var body: some View {
        VStack(spacing: 18) {
            TextField("Title", text: $title)
                .font(.title)
                .padding()
                .background(Color(.secondarySystemFill))
                .cornerRadius(5)
            TextEditor(text: $text)
                .padding()
                .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.secondarySystemFill), lineWidth: 5))
                .cornerRadius(5)
            ColorPicker("Color:", selection: $color).frame(maxHeight: 50)
            Spacer()
            Button {
                self.viewModel.saveTextPost(contentID: content.id, title: title, text: text, color: color)
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Save Post")
            }
            .buttonStyle(NormalButtonStyle())
        }
        .onAppear {
            title = content.title
            text = content.content as! String
            color = content.color
        }
        .padding()
        .navigationBarTitle("Text Post")
    }
}

//struct TextContentCreationView_Previews: PreviewProvider {
//    static var previews: some View {
//        TextContentCreationView(id: "12345")
//    }
//}

