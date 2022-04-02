//
//  CreateBoardOptionView.swift
//  Boards
//
//  Created by Dylan Mace on 6/23/21.
//

import SwiftUI


struct CreatePost: View {
    @EnvironmentObject var viewModel: BoardContentViewModel
    @State private var actionState: PostType = .none
    
    func displayCorrectView(_ selectedOption: PostType) -> some View {
        switch selectedOption {
        case .text:
            return AnyView(TextContentEditView().environmentObject(viewModel))
        case .image:
            return AnyView(LoginView().environmentObject(viewModel))
        case .none:
            return AnyView(Text("Select a view type"))
        }
    }
    
    var body: some View {
        VStack {
            Picker("Choose New Post Type", selection: $actionState) {
                Text("Text").tag(PostType.text)
                Text("Image").tag(PostType.image)
            }
            .pickerStyle(.segmented)
            
            displayCorrectView(actionState)
            Spacer()
        }
        .padding()
        .navigationTitle("Create Post")
    }
}

//struct CreateBoardOptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateBoardOptionView()
//    }
//}


