//
//  BoardViewModel.swift
//  Dreamer
//
//  Created by Dylan Mace on 6/16/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

class BoardViewModel: ObservableObject {
    private var db = Firestore.firestore()
    @Published var boards = [Board]()
    
    
    // code to fetch data
    func fetchData() {
        if let userid = Auth.auth().currentUser?.uid {
            print("User ID: \(userid)")
            db.collection("boards").whereField("users", arrayContains: userid).addSnapshotListener { (querySnapshot, error) in //addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                self.boards = documents.map { queryDocumentSnapshot -> Board in
                    let data = queryDocumentSnapshot.data()
                    let id = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let colorArray = data["color"] as? [Double] ?? [1,1,1,1]
                    let color = Color(.sRGB, red: colorArray[0], green: colorArray[1], blue: colorArray[2], opacity: colorArray[3])
                    let users = data["users"] as? [String] ?? []
                    let lastEdited = (data["lastEdited"] as? Timestamp ?? Timestamp()).dateValue()
                    
                    return Board(id: id, name: name, color: color, users: users, lastEdited: lastEdited)
                }
            }
        }
    }
    
    func deleteBoards(rows: IndexSet, completion: @escaping (Error?) -> Void) {
        rows.sorted(by: > ).forEach { index in
            db.collection("boards").document(self.boards[index].id).delete() { error in
                if error != nil {
                    completion(error)
                    return
                }
            }
        }
    }
    
    func createBoard(id: String, name: String, color: Color) throws {
        guard name != "" else {
            throw RuntimeError("Name and color must both be specified.")
        }
        let (r,g,b,o) = color.components
        print(id)
        if let user = Auth.auth().currentUser {
            db.collection("boards").document(id).setData([
                "id": id,
                "name": name,
                "users": [user.uid],
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
    }

}
