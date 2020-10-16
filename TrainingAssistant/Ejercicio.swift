//
//  Ejercicio.swift
//  TrainingAssistant
//
//  Created by user181023 on 10/16/20.
//

import UIKit

class Ejercicio: NSObject {
    
    var nombre: String!
    var descripcion: String?
    var url: URL?
    
    init(nombre: String, descripcion: String?, url: URL?) {
        self.nombre = nombre
        self.descripcion = descripcion
        self.url = url       
    }
}
