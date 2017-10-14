//
//  ProfileTableViewController.swift
//  chatBuddy
//
//  Created by Ammy Pandey on 11/10/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit
import Firebase

class ProfileTableViewController: UITableViewController {

    var selectedUser: UserOf?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProfileManager.fillUser {
            DispatchQueue.main.async {
               self.tableView.reloadData()
            }
        }

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ProfileManager.users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell")
        
        let u = ProfileManager.users[indexPath.row]
        cell?.textLabel?.text = u.username
        return cell!
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    selectedUser = ProfileManager.users[indexPath.row]
    performSegue(withIdentifier: "showChat", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChat", let vc = segue.destination as? ChatViewController {
                vc.selectedUser = selectedUser
            }
        }
    }
    

