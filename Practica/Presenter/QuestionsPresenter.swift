//
//  QuestionsPresenter.swift
//  Practica
//
//  Created by Juan Gerardo Cruz on 30/12/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import UIKit

protocol QuestionTableDelegate {
    func sections (sections: Int)
    func question (question: Preguntas)
}

protocol QuestionCellDelegate {
    func totalQuestion(total: Int, number: Int)
}

class QuestionPresenter {
    typealias View = QuestionTableDelegate
    typealias Cell = QuestionCellDelegate
    private let model: LoadQuestionNet
    private var delegate: QuestionTableDelegate?
    private var delegateCell: QuestionCellDelegate?
    private var question = [Preguntas]()
    private var pagination: Int = 1
    
    init (model: LoadQuestionNet) {
        self.model = model
    }
    
    func attachView(delegate: View) {
        self.delegate = delegate
    }
    
    func detachView() {
        self.delegate = nil
    }
    
    func attachCell(delegate: Cell) {
        self.delegateCell = delegate
    }
    
    func detachCell() {
        self.delegateCell = nil
    }
    
    func initialQuestion() {
        self.question = self.model.loadQuestion()
        self.delegate?.sections(sections: 2)
        self.delegate?.question(question: self.question[pagination - 1])
    }
    
    func backQuestion() {
        if pagination > 1 {
          pagination -= 1
          self.delegate?.question(question: self.question[pagination - 1])
        }
    }
    
    func nextQuestion() {
        if pagination < self.question.count {
            self.delegate?.question(question: self.question[pagination])
            pagination += 1
        }
    }
    
    func totalQuestion() {
        self.delegateCell?.totalQuestion(total: self.question.count, number: pagination)
    }
}
