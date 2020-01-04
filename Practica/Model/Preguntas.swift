//
//  Preguntas.swift
//  Practica
//
//  Created by Juan Gerardo Cruz on 29/12/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import Foundation

struct Options {
    var option: String
    var selected: Bool = false
    var correct: Bool = false
}

struct Preguntas {
    var pregunta: String
    var options:[Options]
}

protocol LoadQuestionNet {
    typealias load = [Preguntas]
    func loadQuestion() -> load
}


class StubsPreguntas: LoadQuestionNet {
    
    func loadQuestion() -> load {
        var list = [Preguntas]()
        
        list = [Preguntas(pregunta: "En un torneo de tenis, el jugador que pierde se vuelve a casa. Cuántos jugadores iniciaron este torneo si desde la ronda preliminar hasta la final se han jugado 128 partidos.", options: [Options(option: "Opcion 11"),Options(option: "Opcion 12"), Options(option: "Opcion 13"),Options(option: "Opcion 14")]),
                Preguntas(pregunta: "Tengo 20 metros de cinta roja para hacer lazos en unos paquetes de regalo idénticos. Para cada lazo necesito 50 centímetros de cinta. ¿Cuántos lazos puedo hacer?", options: [Options(option: "Opcion 21"),Options(option: "Opcion 22"), Options(option: "Opcion 23"),Options(option: "Opcion 24")]),
                Preguntas(pregunta: "Si compro un bolígrafo y un lápiz me cobran 1€. Si el bolígrafo cuesta 30 céntimos más que el lápiz, ¿cuánto cuesta el bolígrafo?", options: [Options(option: "Opcion 31"),Options(option: "Opcion 32"), Options(option: "Opcion 33"),Options(option: "Opcion 34")]),
                Preguntas(pregunta: "Pregunta 4", options: [Options(option: "Opcion 41"),Options(option: "Opcion 42"), Options(option: "Opcion 43"),Options(option: "Opcion 44")]),
                Preguntas(pregunta: "Pregunta 5", options: [Options(option: "Opcion 51"),Options(option: "Opcion 52"), Options(option: "Opcion 53"),Options(option: "Opcion 54")])
        ]
        return list
    }
    
    
//    static func listPreguntas () -> [Preguntas] {
//        var list = [Preguntas]()
//
//        list = [Preguntas(pregunta: "Pregunta 1", option: ["Opcion 11","Opcion 12", "Opcion 13","Opcion 14"]),
//                Preguntas(pregunta: "Pregunta 2", option: ["Opcion 21","Opcion 22", "Opcion 23","Opcion 24"]),
//                Preguntas(pregunta: "Pregunta 3", option: ["Opcion 31","Opcion 32", "Opcion 33","Opcion 34"]),
//                Preguntas(pregunta: "Pregunta 4", option: ["Opcion 41","Opcion 42", "Opcion 43","Opcion 44"]),
//                Preguntas(pregunta: "Pregunta 5", option: ["Opcion 51","Opcion 52", "Opcion 53","Opcion 54"])
//        ]
//        return list
//    }
    
}
