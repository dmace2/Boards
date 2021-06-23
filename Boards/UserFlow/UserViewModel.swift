//
//  UserViewModel.swift
//  Dreamer
//
//  Created by Dylan Mace on 6/17/21.
//

import Foundation
import FirebaseFirestore

class UserViewModel: ObservableObject {
    private let db = Firestore.firestore()
    
    func getUser(from id: String, completion: @escaping (User, Error?) -> Void) {
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
}
