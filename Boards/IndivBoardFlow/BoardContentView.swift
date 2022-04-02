//
//  BoardContentView.swift
//  Boards
//
//  Created by Dylan Mace on 4/1/22.
//
import SwiftUI


struct BoardContentView: View {
    @EnvironmentObject private var viewModel: BoardContentViewModel
    @State private var isShowingDetailView = false
    
    @State var showingAlert = false
    @State var alertText = ""
    
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.content.sorted(by: {$0.timestamp > $1.timestamp})) { post in
//                    Text(post.type)
                    if post.type == .text {
                        NavigationLink(destination: TextContentEditView(post).environmentObject(viewModel)) {
                            TextContentView(post)
                        }
                    } else if post.type == .image {
                        ImageContentView(post)
                    }
                    //TODO: add in image view
                }
                .onDelete(perform: delete)
            }
            .listStyle(.plain)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .onAppear {
            self.viewModel.fetchData()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error Deleting Board"), message: Text(alertText))
        }
        .navigationTitle(viewModel.board.name)
        .navigationBarItems(trailing:
                                NavigationLink(destination: CreatePost()
                                    .environmentObject(viewModel),
                                               label: { Image(systemName: "plus")})
                                .animation(.easeInOut(duration: 0.3))
                            )
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
