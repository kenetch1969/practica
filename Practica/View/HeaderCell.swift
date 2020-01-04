//
//  HeaderCell.swift
//  Practica
//
//  Created by Juan Gerardo Cruz on 28/12/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
// Para stackview https://spin.atomicobject.com/2017/02/07/uistackviev-proportional-custom-uiviews/

import UIKit

protocol HeaderCellDelegate  {
    func ArrowLeft()
    func ArrowRight()
}

class HeaderCell: UITableViewCell {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var preguntaLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var numeroPreguntaLabel: UILabel!
    

    var delegate: HeaderCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
        selectionStyle = .none
        headerView.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
    @IBAction func leftButton(_ sender: UIButton) {
        self.delegate?.ArrowLeft()
    }
    
    @IBAction func rightButton(_ sender: UIButton) {
        self.delegate?.ArrowRight()
    }
}

extension HeaderCell: QuestionCellDelegate {
    func totalQuestion(total: Int, number: Int) {
        self.totalLabel.text = "Total: \(total)"
        self.numeroPreguntaLabel.text = "Num: \(number)"
    }
}
