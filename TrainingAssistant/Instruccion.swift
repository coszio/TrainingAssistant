//
//  Instruccion.swift
//  TrainingAssistant
//
//  Created by user181023 on 10/16/20.
//

import UIKit

class Instruccion: NSObject {

    var reps: Int?
    var tiempo: TimeInterval?
    var ciclos: Int!
    var descanso: TimeInterval!
    var descansoFinal: TimeInterval!
    
    init(reps: Int, ciclos: Int, descanso: TimeInterval, descansoFinal: TimeInterval) {
        self.reps = reps
        self.ciclos = ciclos
        self.descanso = descanso
        self.descansoFinal = descansoFinal
    }
    
    init(tiempo: TimeInterval, ciclos: Int, descanso: TimeInterval, descansoFinal: TimeInterval) {
        self.tiempo = tiempo
        self.ciclos = ciclos
        self.descanso = descanso
        self.descansoFinal = descansoFinal
    }
}
