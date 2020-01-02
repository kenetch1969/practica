//
//  HeaderCell.swift
//  Practica
//
//  Created by Juan Gerardo Cruz on 28/12/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
// Para stackview https://spin.atomicobject.com/2017/02/07/uistackviev-proportional-custom-uiviews/

import UIKit

class QuestionCell: UITableViewCell {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
