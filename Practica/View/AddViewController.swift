//
//  AddViewController.swift
//  Practica
//
//  Created by Juan Gerardo Cruz on 11/30/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var generoTextField: UITextField!
    @IBOutlet weak var anioTextField: UITextField!
    @IBOutlet weak var imageTextField: UITextField!
    @IBOutlet weak var favoritoButton: UIButton!
    @IBOutlet weak var showImageView: UIImageView!
    
    
    var controller: AddController?
    private let listaGenero = ["Accion", "Aventura", "Drama"]
    private var isFavorito = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Agregar"
        let yourBackImage = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        //self.navigationController?.navigationBar.topItem?.title = "Cancel"
         let backButton = UIBarButtonItem()
         backButton.title = ""
         backButton.tintColor = .black
         self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
      
        // Do any additional setup after loading the view.
        let pickerGenero = UIPickerView()
        pickerGenero.delegate = self
        pickerGenero.dataSource = self
        self.generoTextField.inputView = pickerGenero
        self.generoTextField.text = listaGenero[0]
        
        let tag = UITapGestureRecognizer(target: self, action: #selector(dismissKey))
        tag.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tag)
        
        setImage()
    }
    
    private func setImage() {
        guard let link = imageTextField.text, let url = URL(string: link) else { return }
        do {
        let data = try Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            showImageView.image = UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func dismissKey() {
        view.endEditing(true)
    }
    
   //Para obtener la vista mediante su identificador
//    // InputViewController.swift
//    @IBAction func nextTapped(_ sender: Any) {
//        // the name for UIStoryboard is the file name of the storyboard without the .storyboard extension
//        let displayVC : DisplayViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayVC") as! DisplayViewController
//        displayVC.name = "John Cena"
//
//        self.present(displayVC, animated: true, completion: nil)
//    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.backItem?.title = "Cancel"
//    }
    
    
    @IBAction func favoritoAction(_ sender: UIButton) {
        self.isFavorito = !isFavorito
        if isFavorito {
            self.favoritoButton.setImage(UIImage(named: "favorite"), for: .normal)
        } else {
            self.favoritoButton.setImage(UIImage(named: "unfavorite"), for: .normal)
        }
    }
    
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        guard let titulo = self.tituloTextField.text, !titulo.isEmpty else {
            showAlerta(title: "Add", message: "Titulo vacio")
            return
        }
        
        guard let genero = self.generoTextField.text, !genero.isEmpty else {
            showAlerta(title: "Add", message: "Genero vacio")
            return
        }
        
        guard let anio = self.anioTextField.text, !anio.isEmpty else {
            showAlerta(title: "Add", message: "Año vacio")
            return
        }
        
        guard let imagen = self.imageTextField.text else {
            showAlerta(title: "Add", message: "Image nulo")
            return
        }
        
        if let resp = self.controller?.save(titulo: titulo, genero: genero, anio: anio, imagen: imagen, favorito: isFavorito) {
            if resp {
                print("Si se salvo")
                navigationController?.popViewController(animated: true)
            } else {
                showAlerta(title: "Add", message: "No se salvo")
            }
        }
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

extension AddViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listaGenero[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.generoTextField.text = listaGenero[row]
    }
    
}

extension AddViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listaGenero.count
    }
    
    
}


