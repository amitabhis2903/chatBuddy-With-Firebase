//
//  PostManager.swift
//  chatBuddy
//
//  Created by Ammy Pandey on 11/10/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit
import Firebase

class PostManager: NSObject {

    static let databaseRef = Database.database().reference()
    static var posts = [Posts]()
    
    static func addPost(username: String, text: String, toId: String, fromId: String){
        let p = Posts(username: username, text: text, toId: toId)
        if (p.text != "") {
            let uid = Auth.auth().currentUser?.uid
            let post = ["uid": uid!, "username": p.username, "text": p.text, "toId": p.toId]
            databaseRef.child("posts").childByAutoId().setValue(post)
        }
    }
    
    
    
    static func fillPost(uid: String?, toId: String, completion: @escaping(_ result: String) -> Void) {
        
        posts = []
        let allPost = databaseRef.child("posts")
        print(allPost)
        let post = databaseRef.child("posts").queryOrdered(byChild: "uid").queryEqual(toValue: FirebaseManager.currentUser?.uid).observe(.childAdded, with: { (snapshot) in
            print(snapshot)
        })
        
        databaseRef.child("posts").queryOrdered(byChild: "uid").queryEqual(toValue: FirebaseManager.currentUser?.uid).observe(.childAdded, with: { (snapshot) in
            
            print(snapshot)
            
            if let result = snapshot.value as? [String: AnyObject] {
                let toIdCloud = result["toId"]! as! String
                if (toIdCloud == toId) {
                    let p = Posts(username: result["username"]! as! String, text: result["text"]! as! String, toId: result["toId"]! as! String)
                    PostManager.posts.append(p)
                }
            }
            
            completion("") 
        })
    }
    
}

class Posts {
    var username: String = ""
    var text: String = ""
    var toId: String = ""
    
    init(username: String, text: String, toId: String) {
        self.username = username
        self.text = text
        self.toId = toId
    }
}
