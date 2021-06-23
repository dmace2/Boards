//
//  BoardsApp.swift
//  Boards
//
//  Created by Dylan Mace on 6/23/21.
//

import SwiftUI
import Firebase

@main
struct BoardsApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        let loginModel = LoginModel()
        
        WindowGroup {
            LoginView().environmentObject(loginModel)
            
        }
    }
}
