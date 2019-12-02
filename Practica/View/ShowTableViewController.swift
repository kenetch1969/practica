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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
