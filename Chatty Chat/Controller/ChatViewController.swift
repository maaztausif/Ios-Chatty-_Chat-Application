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
import ChameleonFramework

class ChatViewController: UIViewController ,GIDSignInUIDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{

    @IBOutlet weak var uiViewText: UIView!
    @IBOutlet weak var heightConstraint:NSLayoutConstraint!
    @IBOutlet weak var buttonSend: UIButton!
    @IBOutlet weak var txt_Msg: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    
    var messageArray : [Message] = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.uiDelegate = self
        messageTableView.delegate = self
        messageTableView.dataSource = self
        txt_Msg.delegate = self
        //txt_Msg.text! = "asd"
        
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        
        messageTableView.separatorStyle = .none
        configureTableView()
        // Do any additional setup after loading the view.
        retrieveMessage()
    }
    
    
    
    @objc func tableViewTapped() {
        txt_Msg.endEditing(true)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        cell.avatarImageView.image = UIImage(named: "egg")
        
        
        if cell.senderUsername.text == Auth.auth().currentUser?.email{
       //     cell.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) * 2);
           // cell.transform = CGAffineTransform()
         //   cell.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, conversationTableView.bounds.size.width - 8.0)

            cell.messageBackground.backgroundColor = UIColor.flatBlue()
            cell.avatarImageView.backgroundColor = UIColor.flatNavyBlue()
            
        }else{
            cell.avatarImageView.backgroundColor = UIColor.flatPinkColorDark()
            cell.messageBackground.backgroundColor = UIColor.flatPink()
            
        }
        
        return cell
    }
    
    
    
    
    func configureTableView(){
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        UIView.animate(withDuration: 0.5) {
           self.heightConstraint.constant = 362
           self.view.layoutIfNeeded()
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
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
        
        txt_Msg.endEditing(true)
        txt_Msg.isEnabled = false
        buttonSend.isEnabled = false
        
        let messageDB = Database.database().reference().child("Messages")
        
        let messageDictionary = ["Sender":Auth.auth().currentUser?.email,"MessageBody":txt_Msg.text!]
        
        messageDB.childByAutoId().setValue(messageDictionary) { (error, refrence) in
            if error != nil{
                print("saving into database \(error)===================")
            }else{
                print("message saved dictionary ========================")
                self.txt_Msg.isEnabled = true
                self.txt_Msg.text = ""
                self.buttonSend.isEnabled = true
                
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
