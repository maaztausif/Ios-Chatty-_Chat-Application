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

class ChatViewController: UIViewController ,GIDSignInUIDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.uiDelegate = self
        // Do any additional setup after loading the view.
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


}
