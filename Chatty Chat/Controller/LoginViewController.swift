//
//  LoginViewController.swift
//  Chatty Chat
//
//  Created by Maaz Bin Tausif on 27/03/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import SVProgressHUD

class LoginViewController: UIViewController,GIDSignInUIDelegate {
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_Password: UITextField!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 26, y: 450, width: view.frame.width - 32, height: 350)
        view.addSubview(googleButton)
        GIDSignIn.sharedInstance().uiDelegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
        
    }
    
    
    @IBAction func buttonLogin(_ sender: Any) {
        SVProgressHUD.show()
        if (txt_Email.text! == "" || txt_Password.text! == ""){
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "Error!", message: "Some Field is Missing", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action) in
                
            }
            alert.addAction(action)
            self.present(alert,animated: true,completion: nil)
            
        }else{
            Auth.auth().signIn(withEmail: txt_Email.text!, password: txt_Password.text!) { (auth, error) in
                if error != nil{
                    SVProgressHUD.dismiss()
                    print("User ID or PASSWORD is Wrong = \(error)")
                    
                    let alert = UIAlertController(title: "Wrong!", message: "Wrong email or password", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        
                    })
                    let action2 = UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                        
                    })
                    alert.addAction(action)
                    alert.addAction(action2)
                    
                    self.present(alert,animated: true,completion: nil)
                    
                    self.txt_Password.text! = ""
                }else{
                    SVProgressHUD.dismiss()
                    self.performSegue(withIdentifier: "goToChat", sender: self)
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
extension LoginViewController:GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error{
            print("Google signIn error = =========================\(error)")
        }else{
            guard let authentication = user.authentication else {return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error{
                    print("SignIn Error Firebase ==========================\(error)")
                }else{
                    print("Sign in with firebase Complete============================")
                    self.performSegue(withIdentifier: "goToChat", sender: self)
                    
                }
            }
        }
    
    
}
}
