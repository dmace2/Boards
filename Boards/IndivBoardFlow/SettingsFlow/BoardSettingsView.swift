//
//  BoardSettingsView.swift
//  Dreamer
//
//  Created by Dylan Mace on 6/17/21.
//

import SwiftUI

struct BoardSettingsView: View {
    @State var textNameField: String = ""
    @State private var bgColor = Color(.sRGB, red: 1, green: 1, blue: 1)
    @State private var showingAlert = false
    @State private var alertText = ""
    
    var board: Board
    @StateObject private var viewModel = BoardSettingsViewModel()
    
    init(_ board: Board) {
        self.board = board
    }
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Board Information")) {
                    HStack() {
                        Spacer()
                        Image(systemName: "note.text")
                            .resizable().scaledToFit()
                            .padding()
                            .frame(width: 100)
                        Spacer()
                    }
                    HStack {
                        Text("Name:")
                        Spacer()
                        TextField("Board Name:", text: $textNameField)
                            .padding()
                            .background(Color(.secondarySystemFill))
                            .cornerRadius(5)
                            .multilineTextAlignment(.center)
                            .onAppear {
                                textNameField = board.name
                            }
                        Spacer()
                    }
                    HStack {
                        Text("Color:")
                        Spacer()
                        ColorPicker("", selection: $bgColor)
                            .padding()
                            .onAppear {
                                let (r,g,b,o) = board.color.components
                                bgColor = Color(.sRGB, red: r, green: g, blue: b, opacity: o)
                            }
                        Spacer()
                    }
                }
                
                Section(header: Text("Users")) {
                    ForEach(viewModel.editors) { user in
                        UserView(user)
                            .deleteDisabled(viewModel.idMatch(user.id))
                        
                    }
                    .onDelete(perform: { indexSet in
                        self.viewModel.removeUserFromBoard(at: indexSet, boardID: board.id)
//                        self.viewModel.getAuthorizedUsers(from: board.id)
                    })
                }
                .onAppear() {
                    self.viewModel.getAuthorizedUsers(from: board.id)
                    
                }
                
            }
            
            Spacer()
            Button("Submit Changes") {
                viewModel.updateBoardSettings(id: board.id, name: textNameField, color: bgColor, completion: { error in
                    if let e = error {
                        alertText = e.localizedDescription
                        showingAlert = true
                    }
                })
            }
            .buttonStyle(NormalButtonStyle())
            .padding()
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error Saving Changes"), message: Text(alertText))
            }
        }
        .navigationTitle("Board Settings")
    }
}

struct BoardSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        BoardSettingsView(Board(id: "12345", name: "Test", color: .red, users: [], lastEdited: Date()))
    }
}
