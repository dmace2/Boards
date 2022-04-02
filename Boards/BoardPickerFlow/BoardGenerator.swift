//
//  BoardGenerator.swift
//  Boards
//
//  Created by Dylan Mace on 4/1/22.
//


import SwiftUI

struct BoardGenerator: View {
    @State var boardname: String = ""
    @State private var bgColor = Color(.sRGB, red: 1, green: 1, blue: 1)
    
    @EnvironmentObject var boardManagerModel: BoardViewModel
    
    @State var showingAlert = false
    @State var alertText = ""
    
    var id: String = UUID().uuidString
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Board Name:",text: $boardname)
                .padding()
                .background(Color(.secondarySystemFill))
                .cornerRadius(5)
                .padding()
            ColorPicker("Board Color:", selection: $bgColor)
                .frame(maxHeight: 50)
                .padding()
            Spacer()
            HStack(alignment: .bottom) {
                Button("Create Board") {
                    print(id)
                    do {
                        try self.boardManagerModel.createBoard(id: id, name: boardname, color: bgColor)
                        self.presentationMode.wrappedValue.dismiss()
                    } catch {
                        print(error)
                        alertText = error.localizedDescription
                        showingAlert = true
                    }
                    
                }
                .buttonStyle(NormalButtonStyle())
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error Creating Board"), message: Text(alertText))
                }
            }
        }
        .navigationTitle("Create Board")
        .padding()
    }
}
