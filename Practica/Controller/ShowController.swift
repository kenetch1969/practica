//
//  ShowController.swift
//  Practica
//
//  Created by Juan Gerardo Cruz on 11/30/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ShowController {
    
    
    private var peliculas = [NSManagedObject]()
    
    init() {
        Persistencia.shared.fetchAll { (response, data) in
            self.peliculas = data
        }
    }
    
    func getItem(indexPath: IndexPath) -> NSManagedObject {
        return self.peliculas[indexPath.row]
    }
    
    func getAll() -> [NSManagedObject] {
        return peliculas
    }
    
    func count() -> Int {
        return peliculas.count
    }
    
    func update(isFavorito: Bool, pelicula: Peliculas) -> Bool{
       return Persistencia.shared.update(favorito: isFavorito, item: pelicula)
    }
    
}
