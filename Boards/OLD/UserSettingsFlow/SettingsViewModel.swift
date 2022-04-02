//
//  SettingsViewModel.swift
//  Dreamer
//
//  Created by Dylan Mace on 6/17/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SettingsViewModel: ObservableObject {
    @Published var user: User = User(id: "12345", name: "xyz", imageURL: nil, email: "xyz")
    private let db = Firestore.firestore()
    
    
    func fetchUserData() {
        if let userid = Auth.auth().currentUser?.uid {
            db.collection("users").document(userid).addSnapshotListener { (querySnapshot, error) in //addSnapshotListener { (querySnapshot, error) in
                self.user = querySnapshot.map { queryDocumentSnapshot -> User in
                    let data = queryDocumentSnapshot.data()
                    let name = data?["name"] as? String ?? ""
                    let email = data?["email"] as? String ?? ""
                    let imageURL = data?["imageURL"] as? String ?? ""
                    
                    return User(id: userid, name: name, imageURL: imageURL, email: email)
                } as! User
                print(self.user)
            }
        }
    }
    
    func updateUserInfo() {
        if Auth.auth().currentUser != nil {
            db.collection("users").document(self.user.id).setData([
                "name": self.user.name,
            ], merge: true) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
    }
    
}
