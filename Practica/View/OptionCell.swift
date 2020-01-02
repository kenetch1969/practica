//
//  HeaderCell.swift
//  Practica
//
//  Created by Juan Gerardo Cruz on 28/12/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
// Para stackview https://spin.atomicobject.com/2017/02/07/uistackviev-proportional-custom-uiviews/

import UIKit

class OptionCell: UITableViewCell {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var optionLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
        selectionStyle = .none
        headerView.layer.cornerRadius = 12
//        headerView.layer.borderWidth = 1.0
//        headerView.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
