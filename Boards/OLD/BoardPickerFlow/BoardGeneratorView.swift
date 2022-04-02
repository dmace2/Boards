//
//  BoardGeneratorView.swift
//  Dreamer
//
//  Created by Dylan Mace on 6/16/21.
//

import SwiftUI

struct BoardGeneratorView: View {
    @State var boardname: String = ""
    @State private var bgColor = Color(.sRGB, red: 1, green: 1, blue: 1)
    
    @ObservedObject var viewModel = BoardViewModel()
    
    @State var showingAlert = false
    @State var alertText = ""
    
    var id: String = UUID().uuidString
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            TextField("Board Name:",text: $boardname)
                .padding()
                .background(Color(.secondarySystemFill))
                .cornerRadius(5)
                .padding()
            ColorPicker("Board Color", selection: $bgColor)
                .padding()
            Spacer()
            HStack(alignment: .bottom) {
                Button("Create Board") {
                    print(id)
                    do {
                        try self.viewModel.createBoard(id: id, name: boardname, color: bgColor)
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
