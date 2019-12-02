//
//  AddController.swift
//  Practica
//
//  Created by Juan Gerardo Cruz on 11/30/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import Foundation

class AddController {
    
    func save(titulo: String, genero: String, anio: String, imagen: String, favorito: Bool) -> Bool {
       return Persistencia.shared.insert(titulo: titulo, genero: genero, anio: anio, imagen: imagen, favorito: favorito)
    }
    
}
