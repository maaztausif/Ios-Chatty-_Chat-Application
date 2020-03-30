//
//  RegisterViewController.swift
//  Chatty Chat
//
//  Created by Maaz Bin Tausif on 27/03/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import GoogleSignIn


class RegisterViewController: UIViewController ,GIDSignInUIDelegate{
    
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    @IBOutlet weak var ButtonReg: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 26, y: 450, width: view.frame.width - 32, height: 350)
        view.addSubview(googleButton)
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }
    
    @IBAction func registerButton(_ sender: Any) {
        SVProgressHUD.show()
// For email and pw empty field
        if (txt_Email.text == "" && txt_Password.text == "") {
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "Some text field is missing", message: "Check Carefully", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action) in
            }
            
            alert.addAction(action)
            self.present(alert,animated: true,completion: nil)
        }
//FOr less then 6 charachter password = pw
        else  if let pwCount = txt_Password.text?.count {
            if pwCount <= 5{
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "Password is less then 6 charachet", message: "Greater then 6 Charachter", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (action) in

            }
                alert.addAction(action)
                self.present(alert,animated: true,completion: nil)
        }

            else{
                Auth.auth().createUser(withEmail: txt_Email.text!, password: txt_Password.text!) { (user, error) in
                    if error != nil{
                        SVProgressHUD.dismiss()
                        
                        let alert = UIAlertController(title: "Error", message: "Wrong Id", preferredStyle: .alert)
                        let action = UIAlertAction(title:"OK", style: .default, handler: { (action) in
                            
                            print("ACTION PERFORM")
                        })
                        alert.addAction(action)
                        self.present(alert,animated: true,completion: nil)
                        
                        print("not created==========================")
                    }else{
                        SVProgressHUD.dismiss()
                        self.performSegue(withIdentifier: "goToChat", sender: self)
                    }
                }
            }
        
 
        
    }
    
    }
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
