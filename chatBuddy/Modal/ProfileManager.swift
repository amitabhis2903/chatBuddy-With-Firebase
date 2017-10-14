//
//  ProfileManager.swift
//  chatBuddy
//
//  Created by Ammy Pandey on 11/10/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit
import Firebase

class ProfileManager: NSObject {

    static let databaseRef = Database.database().reference()
    static let uid = Auth.auth().currentUser?.uid
    
    static var users = [UserOf]()
    
    static func getUser(uid: String) -> UserOf? {
        
        if let i = users.index(where: {$0.uid == uid}){
             return users[i]
        }
        
        return nil
    }
    
    static func fillUser(completion: @escaping () -> Void) {
        
        users = []
        
        databaseRef.child("users").observe(.childAdded, with: { (snapshot) in
            print(snapshot)
            
            if let result = snapshot.value as? [String: AnyObject] {
                let uid = result["uid"]! as! String
                let username = result["username"]! as! String
                let email = result["email"]! as! String
                
                let u = UserOf(username: username, email: email, uid: uid)
                
                ProfileManager.users.append(u)
            }
            completion()
        })
        
    }
    
}
