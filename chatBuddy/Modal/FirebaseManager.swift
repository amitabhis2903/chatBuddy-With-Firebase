//
//  FirebaseManager.swift
//  chatBuddy
//
//  Created by Ammy Pandey on 11/10/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit
import Firebase
class FirebaseManager: NSObject {
    
    static let databaseRef = Database.database().reference()
    static var currentUserId: String = ""
    static var currentUser: User? = nil
    
    
    static func Login(email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                print(error)
                completion (false)
            }else {
                currentUser = user
                currentUserId = (user?.uid)!
                completion (true)
            }
        }
        
    }
    
    
    static func createUser(username: String, email: String, password: String, completion: @escaping (_ result: String) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error)
                return
            }
            addUser(username: username, email: email)
            Login(email: email, password: password, completion: { (success:Bool) in
                if (success) {
                    print("Login Successfully after creation")
                }else {
                    print("Login Unsuccessful after account creation")
                }
                completion("")
            })
        }
    }
    
    static func addUser(username: String, email: String) {
        
        let uid = Auth.auth().currentUser?.uid
        let post = ["uid": uid!, "username": username, "email": email]
        databaseRef.child("users").child(uid!).setValue(post)
        
    }

}
