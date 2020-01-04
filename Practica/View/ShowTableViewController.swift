//
//  ShowTableViewController.swift
//  Practica
//
//  Created by Juan Gerardo Cruz on 11/30/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import UIKit

protocol ShowTableViewCellDelegate {
    func favorito(_ cell: ShowTableViewCell,_ isFavorito: Bool)
}


class ShowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var generoLabel: UILabel!
    @IBOutlet weak var anioLabel: UILabel!
    @IBOutlet weak var imagenImageView: UIImageView!
    @IBOutlet weak var favoritoButton: UIButton!
    
    var delegate: ShowTableViewCellDelegate?
    private var isFavorito = false
    
    func setFavorito(favorito: Bool) {
        self.isFavorito = favorito
         if isFavorito {
             self.favoritoButton.setImage(UIImage(named: "favorite"), for: .normal)
         } else {
             self.favoritoButton.setImage(UIImage(named: "unfavorite"), for: .normal)
         }
    }
    
    
    @IBAction func actionFavorito(_ sender: UIButton) {
        self.isFavorito = !isFavorito
        if isFavorito {
            self.favoritoButton.setImage(UIImage(named: "favorite"), for: .normal)
            self.delegate?.favorito(self,true)
        } else {
            self.favoritoButton.setImage(UIImage(named: "unfavorite"), for: .normal)
            self.delegate?.favorito(self,false)
        }
    }
    
    
}

class ShowTableViewController: UITableViewController {

    var controller: ShowController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Mostrar"

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return controller?.count() ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! ShowTableViewCell
        
        // Configure the cell...
        if let pelicula = controller?.getItem(indexPath: indexPath) {
            cell.delegate = self
            cell.tituloLabel.text = "Titulo: \(pelicula.value(forKey: "titulo") ?? "")"
            cell.generoLabel.text = "Genero: \(pelicula.value(forKey: "genero") ?? "")"
            cell.anioLabel.text = "Año: \(pelicula.value(forKey: "anio") ?? "")"
            cell.setFavorito(favorito: pelicula.value(forKey: "favorito") as? Bool ?? false)
            cell.imagenImageView.downloadImageFromServer(link: pelicula.value(forKey: "imagen") as? String ?? "", contentMode: .scaleToFill)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
}

extension ShowTableViewController: ShowTableViewCellDelegate {
    func favorito(_ cell: ShowTableViewCell, _ isFavorito: Bool) {
        if let indexPath = tableView.indexPath(for: cell),  let pelicula = controller?.getItem(indexPath:indexPath) {
            if let resp = controller?.update(isFavorito: isFavorito, pelicula: pelicula as! Peliculas) {
                if resp {
                  showAlerta(title: "Show", message: "Registro modificado")
                }
            }
        }
    }
}
