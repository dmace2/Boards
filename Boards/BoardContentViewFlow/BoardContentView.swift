//
//  BoardContentView.swift
//  Dreamer
//
//  Created by Dylan Mace on 6/16/21.
//

import SwiftUI

struct BoardContentView: View {
    var board: Board
    @ObservedObject var viewModel: BoardContentViewModel
    let columns = [
        GridItem(.flexible()),
    ]
    
    init(_ board: Board) {
        self.board = board
        self.viewModel = BoardContentViewModel(from: board)
    }
    
    func placeOrder() { }
    func adjustOrder() { }
    func cancelOrder() { }
    
    var body: some View {
        VStack {
            Menu {
                NavigationLink(destination: Text("Destination_1")) {
                    Label("Text", systemImage: "doc.text")
                }
                NavigationLink(destination: Text("Destination_1")) {
                    Label("Image", systemImage: "photo")
                }
            } label: {
                Spacer()
                Label("New Item", systemImage: "plus")
                Spacer()
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground)).cornerRadius(10)
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.content) {contentItem in
                        if contentItem.type == "text" {
                            TextContentView(contentItem as! TextContent)
                            
                        } else if contentItem.type == "image" {
                            ImageContentView(contentItem as! ImageContent)
                            
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            self.viewModel.fetchData()
        }
        .navigationTitle(board.name)
    }
}

//struct BoardContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        BoardContentView()
//    }
//}
