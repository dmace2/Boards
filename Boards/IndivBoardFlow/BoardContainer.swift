//
//  BoardContainer.swift
//  Boards
//
//  Created by Dylan Mace on 4/1/22.
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
