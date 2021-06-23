//
//  BoardContentViewModel.swift
//  Dreamer
//
//  Created by Dylan Mace on 6/17/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

class BoardSettingsViewModel: ObservableObject {
    private var db = Firestore.firestore()
    @Published var editors: [User] = []
    
    func updateBoardSettings(id: String, name: String, color: Color, completion: @escaping (Error?) -> Void) {
        let (r,g,b,o) = color.components
        db.collection("boards").document(id).setData([
            "name": name,
            "color": [r,g,b,o],
            "lastEdited": Timestamp(date: Date())
        ], merge: true) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func getAuthorizedUsers(from boardID: String) {
        db.collection("boards").document(boardID).getDocument(completion: { (document, error ) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                let userIDList = dataDescription?["users"]
                if let ids = userIDList as? [String] {
                    for userID in ids {
                        self.getUserInfoFromID(userID, completion: { (user, error) in
                            if let error = error {
                                print(error.localizedDescription)
                            } else {
                                print(user)
                                if !self.editors.contains(user) {
                                    self.editors.append(user)
                                }
                            }
                        })
                    }
                }
            } else {
                print("Document does not exist")
            }
        })
    }
    
    func getUserInfoFromID(_ id: String, completion: @escaping (User, Error?) -> Void) {
        db.collection("users").document(id).getDocument(completion: { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                let name = dataDescription?["name"] as? String ?? "Unknown Name"
                let email = dataDescription?["email"] as? String ?? "unknown@unknown.com"
                let imageURL = dataDescription?["profileImage"] as? String
                
                
                completion(User(id: id, name: name, imageURL: imageURL, email: email), nil)
                return
            } else {
                print("Document does not exist")
            }
        })
    }
    
    func idMatch(_ userID: String) -> Bool {
        return Auth.auth().currentUser?.uid == userID
    }
    
    func removeUserFromBoard(at indices: IndexSet, boardID: String) {
        indices.sorted(by: > ).forEach { index in
            print("Index \(index)")
            let removedUser = editors[index]//userList.remove(at: index)
            db.collection("boards").document(boardID).updateData([
                "users": FieldValue.arrayRemove([removedUser.id])
            ])
        }
    }
}

