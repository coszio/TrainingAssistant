//
//  Exercise.swift
//  TrainingAssistant
//
//  Created by user180996 on 10/21/20.
//

import UIKit

class Exercise: NSObject {
    var name : String
    var desc : String?
    var focus : String
    
    //Something
    init (_ exercise : Exercise){
        self.name = exercise.name
        self.desc = exercise.desc
        self.focus = exercise.focus
    }
    
    //Something
    init (_ name : String, _ desc : String?, _ focus : String){
        self.name = name
        self.desc = desc
        self.focus = focus
    }
}
