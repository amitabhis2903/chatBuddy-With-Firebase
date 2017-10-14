//
//  ChatViewController.swift
//  chatBuddy
//
//  Created by Ammy Pandey on 11/10/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chatTable: UITableView!
    @IBOutlet weak var msgTxt: UITextField!
    
    var selectedUser: UserOf?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        PostManager.fillPost(uid: FirebaseManager.currentUser?.uid, toId: (selectedUser?.uid)!){
            (result: String) in
            DispatchQueue.main.async {
                self.chatTable.reloadData()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        PostManager.posts = []
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostManager.posts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let post = PostManager.posts[indexPath.row]
        cell?.textLabel?.text = post.text
        
        return cell!
    }
    @IBAction func sendMsgBtn(_ sender: UIButton) {
        PostManager.addPost(username: (selectedUser?.username)!, text: msgTxt.text!, toId: (selectedUser?.uid)!, fromId: (FirebaseManager.currentUser?.uid)!)
        msgTxt.text = ""
     }
    
}
