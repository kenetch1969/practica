//
//  UIViewController+extension.swift
//  Practica
//
//  Created by Juan Gerardo Cruz on 11/30/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlerta(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let aceptar = UIAlertAction(title: "Aceptar", style: .cancel)
        alert.addAction(aceptar)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
}
