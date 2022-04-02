//
//  BoardView.swift
//  Dreamer
//
//  Created by Dylan Mace on 6/16/21.
//

import SwiftUI

struct BoardListCellView: View {
    var board: Board
    
    init(_ board: Board) {
        self.board = board
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(board.name).font(.title).bold()
                Spacer(minLength: 50)
                Text("Last Edited on \(board.lastEdited)").font(.subheadline)
            }
        }
    }
}
//
//struct BoardListCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        BoardListCellView(Board(id: "12345", name: "Test", color: .red, users: [], lastEdited: Date()))
//    }
//}
