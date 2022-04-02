//
//  BoardPickerFlow.swift
//  Boards
//
//  Created by Dylan Mace on 4/1/22.
//

import SwiftUI
import FirebaseAuth

struct BoardListView: View {
    @StateObject var boardModel = BoardViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(boardModel.boards) { board in
                    NavigationLink(destination: BoardContentContainerView(board)) {
                        ZStack {
                            board.color.cornerRadius(10)
                            BoardListCellView(board).padding()
                        }
//                        .padding()
                        .ignoresSafeArea()
                    }
                    .padding()
                   
                }
                
            }
            .listStyle(.sidebar)
            .onAppear {
                boardModel.fetchData()
            }
        }
        .navigationBarItems(leading: NavigationLink(destination: UserSettingsView(),
                                                    label: { Image(systemName: "gear")})
                                     .animation(.easeInOut(duration: 0.3)),
                            trailing:
                                NavigationLink(destination: BoardGenerator(id: UUID().uuidString)
                                    .environmentObject(boardModel),
                                               label: { Image(systemName: "plus")})
                                .animation(.easeInOut(duration: 0.3))
        )
        .navigationTitle("Boards")
    }
}

struct BoardPickerFlow_Previews: PreviewProvider {
    static var previews: some View {
        BoardListView()
    }
}
