//
//  Persistencia.swift
//  Practica
//
//  Created by Juan Gerardo Cruz on 11/30/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import UIKit
import CoreData


class Persistencia {
    
    static let shared = Persistencia()
    private let appDelegate: AppDelegate?
    private let managerContext: NSManagedObjectContext?
    
    private init() {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.managerContext = self.appDelegate?.persistentContainer.viewContext
    }
    
    func insert(titulo: String, genero: String, anio: String, imagen: String, favorito: Bool) -> Bool {
        if let context = self.managerContext {
           let pelicula = Peliculas(context: context)
            pelicula.titulo = titulo
            pelicula.genero = genero
            pelicula.anio = anio
            pelicula.imagen = imagen
            pelicula.favorito = favorito
            
            do {
                try context.save()
                return true
            }catch {
                return false
            }
        }
      return false
    }
    
    func fetchAll(completion: (Bool, [Peliculas])->()) {
        if let context = self.managerContext {
            let fetchPeliculas: NSFetchRequest<Peliculas> = Peliculas.fetchRequest()
            
            do {
                let pelicula = try context.fetch(fetchPeliculas)
                completion(true, pelicula)
            } catch {
                completion(false, [Peliculas]())
            }
        }
    }
    
    func update (favorito: Bool, item: Peliculas) -> Bool {
        if let context = self.managerContext {
            item.favorito = favorito
            do {
                  try context.save()
                  return true
            }catch {
                  return false
            }
        }
        return false
    }
}
