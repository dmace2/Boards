//
//  UserIDView.swift
//  Dreamer
//
//  Created by Dylan Mace on 6/17/21.
//

import SwiftUI

struct UserIDView: View {
    private var id: String
    @ObservedObject private var viewModel = UserViewModel()
    @State private var user: User?
    
    init(_ id: String) {
        self.id = id
    }
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle").resizable().scaledToFit().frame(maxHeight: 30).padding()
            VStack(alignment: .leading) {
                Text(user?.name ?? "Unknown")
                Text(user?.email ?? "unknown@unknown.com")
            }
        }
        .onAppear {
            self.viewModel.getUser(from: self.id) { (user, error) in
                self.user = user
                
            }
        }
    }
}
