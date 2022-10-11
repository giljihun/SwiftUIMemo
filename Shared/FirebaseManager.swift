//
//  FirebaseManager.swift
//  SwiftUIMemo
//
//  Created by mobicom on 2022/10/11.
//

import Foundation
import Firebase

class FireStoreManager: ObservableObject {
    @Published var freeboardTitle: String = ""
    @Published var freeboardNickName: String = ""
    
    func fetchData() {
            let db = Firestore.firestore()
            let docRef = db.collection("freeboard").document("XOVUhAFR9pZ8mfIUrpKT")
            docRef.getDocument { (document, error) in
                guard error == nil else {
                    print("error", error ?? "")
                    return
                }

                if let document = document, document.exists {
                    let data = document.data()
                    if let data = data {
                        self.freeboardTitle = data["title"] as? String ?? ""
                        self.freeboardNickName = data["nickname"] as? String ?? ""
                    }
                }
            }
        }
    
    init() {
        fetchData()
    }
}

