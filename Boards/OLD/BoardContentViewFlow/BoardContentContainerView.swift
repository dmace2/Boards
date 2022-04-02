//
//  BoardContentContainerView.swift
//  Dreamer
//
//  Created by Dylan Mace on 6/17/21.
//

import SwiftUI

struct BoardContentContainerView: View {
    var board: Board
    
    init(_ board: Board) {
        self.board = board
    }
    
    var body: some View {
        TabView {
            BoardContentView().tabItem({
                Label("Board", systemImage: "note.text")
            })
            BoardSettingsView(board).tabItem({
                Label("Settings", systemImage: "gear")
            })
        }.environmentObject(BoardContentViewModel(from: board))
    }
}

struct BoardContentView_Previews: PreviewProvider {
    static var previews: some View {
        BoardContentContainerView(Board(id: "12345", name: "Test", color: .red, users: [], lastEdited: Date()))
    }
}
