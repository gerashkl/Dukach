//
//  ViewController.swift
//  Dukach
//
//  Created by Illia Marchenko on 22.05.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController  {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
    }

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    
//    }
    @IBAction func logOutButton(_ sender: Any) {
        do{
            try Auth.auth().signOut()
        } catch{
            print(error)
        }
    }
    
}

