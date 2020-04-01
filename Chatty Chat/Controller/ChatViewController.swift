//
//  ChatViewController.swift
//  Chatty Chat
//
//  Created by Maaz Bin Tausif on 27/03/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ChatViewController: UIViewController ,GIDSignInUIDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{

    
    @IBOutlet weak var buttonSend: UIButton!
    @IBOutlet weak var txt_Msg: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    
    var messageArray : [Message] = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.uiDelegate = self
        messageTableView.delegate = self
        messageTableView.dataSource = self
    
        
        messageTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        
        messageTableView.separatorStyle = .none
        configureTableView()
        // Do any additional setup after loading the view.
        retrieveMessage()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.SenderUserName.text = messageArray[indexPath.row].sender
        
        return cell
    }
    
    func configureTableView(){
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    

    @IBAction func signOutButton(_ sender: Any) {
        
        GIDSignIn.sharedInstance()?.signOut()
       // performSegue(withIdentifier: "goToMain", sender: self)
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
        }catch let signOutError as NSError{
            print("Failed to signOut ==========================")
            print(signOutError)
        }
        navigationController?.popToRootViewController(animated: true)

    }

    @IBAction func sendButton(_ sender: Any) {
        let messageDB = Database.database().reference().child("Messages")
        
        let messageDictionary = ["Sender":Auth.auth().currentUser?.email,"MessageBody":txt_Msg.text!]
        
        messageDB.childByAutoId().setValue(messageDictionary) { (error, refrence) in
            if error != nil{
                print("saving into database \(error)===================")
            }else{
                print("message saved dictionary ========================")
            }
        }
        
    }
    
    func retrieveMessage(){
        let messageDB = Database.database().reference().child("Messages")
        
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            
            let message = Message()
            message.messageBody = text
            message.sender = sender
            
            self.messageArray.append(message)
            self.configureTableView()
            self.messageTableView.reloadData()
        }
    }
    
}
