//
//  ViewController.swift
//  Practica
//
//  Created by Juan Gerardo Cruz on 11/30/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Menu"
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueAdd" {
            let vcAdd = segue.destination as? AddViewController
            vcAdd?.controller = AddController()
        }
        
        if segue.identifier == "segueShow" {
            let vcAdd = segue.destination as? ShowTableViewController
            vcAdd?.controller = ShowController()
        }
        
    }
}

