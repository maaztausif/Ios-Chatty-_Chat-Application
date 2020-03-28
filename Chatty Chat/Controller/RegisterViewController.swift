//
//  RegisterViewController.swift
//  Chatty Chat
//
//  Created by Maaz Bin Tausif on 27/03/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButton(_ sender: Any) {
       // performSegue(withIdentifier: "goToChat", sender: self)
        self.performSegue(withIdentifier: "goToChat", sender: self)
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
