//
//  CreateBoardOptionView.swift
//  Boards
//
//  Created by Dylan Mace on 6/23/21.
//

import SwiftUI

enum ActionState: Int {
    case text = 0
    case image = 1
}

struct CreateBoardOptionView: View {
    @EnvironmentObject var viewModel: BoardContentViewModel
    @State private var actionState: ActionState? = .none
    
    var body: some View {
        NavigationLink(destination: TextContentCreationView(content: TextContent(id: UUID().uuidString, title: "", text: "", color: .blue))
                        .environmentObject(viewModel),tag: .text, selection: $actionState) {
            EmptyView()
        }
        NavigationLink(destination: ImageContentCreationView().environmentObject(viewModel),tag: .image, selection: $actionState) {
            EmptyView()
        }
        Menu {
            Button {
                actionState = .text
            } label: {
                Label("Text", systemImage: "doc.text")
            }
            Button {
                actionState = .image
            } label: {
                Label("Image", systemImage: "photo")
            }
            
        } label: {
            Spacer()
            Label("New Item", systemImage: "plus")
            Spacer()
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground)).cornerRadius(10)
    }
}

struct CreateBoardOptionView_Previews: PreviewProvider {
    static var previews: some View {
        CreateBoardOptionView()
    }
}
