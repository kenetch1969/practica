//
//  SecondViewController.swift
//  Practica
//
//  Created by Juan Gerardo Cruz on 12/16/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//  Para la tablas
// https://theswiftdev.com/2018/12/01/uitableview-tutorial-in-swift/

import UIKit

class SecondViewController: UIViewController {

    private var presenter: QuestionPresenter?
    private var tableView: UITableView = {
         let tb = UITableView(frame: .zero)
         tb.separatorStyle = .none
         tb.translatesAutoresizingMaskIntoConstraints = false
         return tb
    }()
    
    private let cellID = "cellID"
    private let sectionHeaderID = "headerID"
    private let questionID = "questionID"
    private let optionID = "optionID"
    private var sections: Int = 0
    private var pregunta: Preguntas?
    
    var test: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: guide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: guide.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: guide.rightAnchor)
        ])
        
        //Cuando es un xib
        let headerNib = UINib.init(nibName: "HeaderCell", bundle: Bundle.main)
        tableView.register(headerNib, forCellReuseIdentifier: sectionHeaderID)
        
        let questionNib = UINib.init(nibName: "QuestionCell", bundle: Bundle.main)
        tableView.register(questionNib, forCellReuseIdentifier: questionID)
        
        let optionNib = UINib.init(nibName: "OptionCell", bundle: Bundle.main)
        tableView.register(optionNib, forCellReuseIdentifier: optionID)
        
        //Cuando es una clase
        tableView.register(ColorfulTableViewCell.self, forCellReuseIdentifier: cellID)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        presenter?.initialQuestion()
    }
    
    func attachPresenter(presenter: QuestionPresenter) {
        self.presenter = presenter
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reload))
    }
    
    @IBAction func reload() {
//        let value = Int.random(in: 1..<100)
//        pregunta?.pregunta = "La pregunta numero \(value)"
//
//        guard let indexPath = tableView.indexPathForSelectedRow else { return }
//        if indexPath.section == 1 {
//            print("Index \(indexPath.item)")
//            if pagination < preguntas.count - 1 {
//               pagination += 1
//               tableView.reloadData()
//            }
//        }
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

extension SecondViewController: QuestionTableDelegate {
    func sections(sections: Int) {
        self.sections = sections
    }
    
    func question(question: Preguntas) {
        self.pregunta = question
        tableView.reloadData()
    }
}

extension SecondViewController: HeaderCellDelegate {
    func ArrowLeft() {
        self.presenter?.backQuestion()
    }
    
    func ArrowRight() {
        self.presenter?.nextQuestion()
    }
}

extension SecondViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return pregunta?.options.count ?? 0
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sectionTitles[section]
//    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: questionID, for: indexPath) as! QuestionCell
            cell.questionLabel.text = pregunta?.pregunta
            return cell
        } else {
        
          let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ColorfulTableViewCell
          // Configure the cell...
          cell.accessoryType = .none
          cell.title = pregunta?.options[indexPath.item].option
          return cell
        }
    }
}

extension SecondViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        }
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Dequeue with the reuse identifier
        switch section {
        case 0:
            let  headerCell = tableView.dequeueReusableCell(withIdentifier: sectionHeaderID) as! HeaderCell
            self.presenter?.attachCell(delegate: headerCell)
            self.presenter?.totalQuestion()
            headerCell.delegate = self
            return headerCell
        default:
            let  optionCell = tableView.dequeueReusableCell(withIdentifier: optionID) as! OptionCell
            return optionCell
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
          return 80
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
                cell.accessoryType = .checkmark
            }
        }

    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
          if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
              cell.accessoryType = .none
          }
        }
    }
}

class ColorfulTableViewCell: UITableViewCell {
    
    var title: String? {
        didSet {
            guard let item = title else { return }
            option.text = item
        }
    }
    
    private var cardView: UIView = {
        let cardView = UIView(frame: .zero)
        cardView.backgroundColor = .lightGray
        cardView.layer.cornerRadius = 12.0
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }()
    
    private var option: UILabel = {
        let lb = UILabel()
        lb.text = "option"
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupGraphic()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGraphic(){
        self.backgroundColor = .clear
        self.selectionStyle = .none
        cardView.addSubview(option)
        NSLayoutConstraint.activate([
            option.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            option.centerXAnchor.constraint(equalTo: cardView.centerXAnchor)
        ])
        
        self.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 13.0),
            cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -13.0),
            cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0),
            cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:  -5.0)
        ])
    }
}
