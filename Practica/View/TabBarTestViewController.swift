//
//  TabBarTestViewController.swift
//  Practica
//
//  Created by Juan Gerardo Cruz on 12/16/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import UIKit

class TabBarTestViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.delegate = self
        setup()
    }
    
    private func setup() {
        let model = StubsPreguntas()
        let presenter = QuestionPresenter(model: model)
        let vc = self.viewControllers![1] as! SecondViewController
        presenter.attachView(delegate: vc)
        vc.attachPresenter(presenter: presenter)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print(segue.identifier ?? "")
    }
    */
}

//extension TabBarTestViewController: UITabBarControllerDelegate {
//
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//
//        if viewController is FirstViewController {
//            print("First tab")
//        } else if viewController is SecondViewController {
//            if let secondVC = viewController as? SecondViewController {
//                secondVC.setup(value: 1)
//            }
//        }
//    }
//}
