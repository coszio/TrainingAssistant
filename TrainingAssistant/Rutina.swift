//
//  Rutina.swift
//  TrainingAssistant
//
//  Created by user181023 on 10/16/20.
//

import UIKit

class Rutina: NSObject {

    var nombre: String!
    var ejercicios: [Ejercicio] = []
    var instrucciones: [Instruccion] = []
    
    init(nombre: String) {
        self.nombre = nombre
    }
    
}
