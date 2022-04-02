//
//  BoardContentView.swift
//  Dreamer
//
//  Created by Dylan Mace on 6/16/21.
//

import SwiftUI


struct BoardContentView: View {
    @EnvironmentObject private var viewModel: BoardContentViewModel
    @State private var isShowingDetailView = false
    
    @State var showingAlert = false
    @State var alertText = ""
    
    private let columns = [
        GridItem(.flexible()),
    ] //one col for items
    
    
    var body: some View {
        VStack {
            CreateBoardOptionView().environmentObject(viewModel).padding(.horizontal, 10)
            List {
                ForEach(viewModel.content) { contentItem in
                    if contentItem.type == "text" {
                        NavigationLink(destination: TextContentCreationView(content: contentItem as! TextContent).environmentObject(viewModel), label: {
                            TextContentView(contentItem as! TextContent)
                        })
                    } else if contentItem.type == "image" {
                        ImageContentView(contentItem as! ImageContent)
                        
                    }
                }
                .onDelete(perform: delete)
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .onAppear {
            self.viewModel.fetchData()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error Deleting Board"), message: Text(alertText))
        }
        .navigationTitle(viewModel.board.name)
    }
    
    func delete(at offsets: IndexSet) {
        viewModel.deleteItems(rows: offsets, completion: { error in
            if let e = error {
                alertText = e.localizedDescription
                showingAlert = true
            }
        })
    }
}

//struct BoardContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        BoardContentView()
//    }
//}
