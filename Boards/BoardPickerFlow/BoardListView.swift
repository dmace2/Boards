//
//  BoardListView.swift
//  Dreamer
//
//  Created by Dylan Mace on 6/16/21.
//

import SwiftUI

struct BoardListView: View {
    @ObservedObject var viewModel = BoardViewModel()
    @EnvironmentObject var loginModel: LoginModel
    
    @State var showingAlert = false
    @State var alertText = ""
    @State var showNewBoardView = false
    
    
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(viewModel.boards) { board in
                        NavigationLink(destination: BoardContentContainerView(board), label: {
                            ZStack {
                                board.color.cornerRadius(10)
                                BoardListCellView(board).padding()
                            }
                            .ignoresSafeArea()
                    
                        })
                        
                    }
                    .onDelete(perform: delete)
                }
                .onAppear() {self.viewModel.fetchData()}
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error Deleting Board"), message: Text(alertText))
                }
            }
            
        }
        .navigationBarItems(leading: NavigationLink(destination: UserSettingsView(),
                                                    label: { Image(systemName: "gear")})
                                     .animation(.easeInOut(duration: 0.3)),
                            trailing:
                                NavigationLink(destination: BoardGeneratorView(id: UUID().uuidString),
                                               label: { Image(systemName: "plus")})
                                .animation(.easeInOut(duration: 0.3))
        )
        .navigationTitle("Boards")
    }
    
    func delete(at offsets: IndexSet) {
        self.viewModel.deleteBoards(rows: offsets, completion: { error in
            if let e = error {
                alertText = e.localizedDescription
                showingAlert = true
            }
        })
    }
}

struct BoardListView_Previews: PreviewProvider {
    static var previews: some View {
        BoardListView()
    }
}
