//
//  Users.swift
//  chatBuddy
//
//  Created by Ammy Pandey on 11/10/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit

class UserOf: NSObject {

    var username: String
    var email: String
    var uid: String
    
    init(username: String, email: String, uid: String) {
        self.username = username
        self.email = email
        self.uid = uid
    }
    
}
