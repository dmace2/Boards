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

class BoardContentViewModel: ObservableObject {
    private var db = Firestore.firestore()
    
    @Published var content: [ContentItem] = []
    var board: Board
    
    init(from board: Board) {
        self.board = board
    }
    
    
    func fetchData() {
        if let userid = Auth.auth().currentUser?.uid {
            print("User ID: \(userid)")
            db.collection("boards").document(board.id).collection("content").addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                self.content = documents.map { queryDocumentSnapshot -> ContentItem in
                    let data = queryDocumentSnapshot.data()
                    let id = data["id"] as? String ?? ""
                    let title = data["title"] as? String ?? ""
                    let type = data["contentType"] as? String ?? ""
                    
                    if type == "text" {
                        let text = data["text"] as? String ?? ""
                        return TextContent(id: id, title: title, text: text)
                    }
                    else if type == "image" {
                        let url = data["url"] as? String ?? ""
                        return ImageContent(id: id, title: title, url: "\(self.board.id)/\(url)")
                    }
                    return TextContent(id: "12345", title: "Title", text: "text")
                }
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
    
    
}
