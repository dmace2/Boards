//
//  LoginView.swift
//  Boards
//
//  Created by Dylan Mace on 4/1/22.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var viewModel: LoginModel
    
    var body: some View {
            ZStack {
                if viewModel.isSignedIn {
                    NavigationView{
                        BoardListView()

                            .navigationTitle("Content")
                    }
                        .navigationViewStyle(.automatic)
                } else {
                    AuthView()
                }
            }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn //computed property
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
