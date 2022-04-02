//
//  BoardContentViewModel.swift
//  Boards
//
//  Created by Dylan Mace on 6/23/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import SwiftUI

class BoardContentViewModel: ObservableObject {
    private var db = Firestore.firestore()
    
    @Published var content: [Post] = []
    var board: Board
    
    init(from board: Board) {
        self.board = board
    }
    
    
    func fetchData() {
        if let userid = Auth.auth().currentUser?.uid {
            print("User ID: \(userid)")
            db.collection("boards").document(board.id).collection("content").order(by: "timestamp").addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                self.content = documents.map { queryDocumentSnapshot -> Post in
                    let data = queryDocumentSnapshot.data()
                    let id = data["id"] as? String ?? ""
                    let title = data["title"] as? String ?? ""
                    let type = PostType(rawValue: data["contentType"] as? String ?? "")!
                    let timestamp = (data["timestamp"] as? Timestamp ?? Timestamp()).dateValue()
                    let c = data["color"] as? [Double] ?? [1,1,1,1]
                    
                    var postContent: Any
                    
                    switch type {
                    case .text:
                        postContent = data["text"] as? String ?? ""
                    case .image:
                        postContent = data["url"] as? String ?? ""
                    default:
                        postContent = "None"
                    }
                    
                    return Post(id: id, title: title, type: type, color: Color(.displayP3, red: c[0], green: c[1], blue: c[2], opacity: c[3]), timestamp: timestamp, content: postContent)
                }
                print(self.content)
            }
        }
    }
    
    func loadImageFromFirebase(urlPath: String, completion: @escaping (URL) -> Void) {
        let storageRef = Storage.storage().reference(withPath: urlPath)
        storageRef.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            completion(url!)
        }
    }
    
    func saveTextPost(contentID: String, title: String, text: String, color: Color) {
        let (r,g,b,o) = color.components
        db.collection("boards").document(board.id).collection("content").document(contentID).setData([
            "contentType": "text",
            "id": contentID,
            "title": title,
            "text": text,
            "color": [r,g,b,o],
            "timestamp": Timestamp(date: Date())
        ], merge: true)
    }
    
    func deleteItems(rows: IndexSet, completion: @escaping (Error?) -> Void) {
        rows.sorted(by: > ).forEach { index in
            db.collection("boards").document(board.id).collection("content").document(self.content[index].id).delete() { error in
                if error != nil {
                    completion(error)
                    return
                }
                print(error)
            }
        }
    }
    
    
}
