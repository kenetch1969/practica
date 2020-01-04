//
//  FirstViewController.swift
//  Practica
//
//  Created by Juan Gerardo Cruz on 12/16/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
         let backItem = UIBarButtonItem()
         backItem.title = "Something Else"
         navigationItem.backBarButtonItem = backItem 
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.themeNavigationBar(mode: .alternate)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.navigationController?.themeNavigationBar(mode: .normal)
    
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

enum NavigationBarMode {
    case normal
    case alternate
}

extension UINavigationController {
    
    func themeNavigationBar(mode: NavigationBarMode) {
        
        self.navigationBar.isTranslucent = false
        
        switch mode {
       
        case .normal:
            navigationBar.tintColor = UIColor.black
            navigationBar.barTintColor = UIColor.lightGray
            let attributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont(name: "Georgia-Bold", size: 24)!
            ]
            navigationBar.titleTextAttributes = attributes
       
        case .alternate:
            navigationBar.tintColor = UIColor.lightGray
            navigationBar.barTintColor = UIColor.black
            let attributes = [
                NSAttributedString.Key.foregroundColor: UIColor.orange,
                NSAttributedString.Key.font: UIFont(name: "Georgia-Bold", size: 24)!
            ]
            navigationBar.titleTextAttributes = attributes
        }
    }

}
