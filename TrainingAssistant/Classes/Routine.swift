//
//  Routine.swift
//  TrainingAssistant
//
//  Created by user180996 on 10/21/20.
//

import UIKit

class Routine: NSObject {
    var name: String
    var goal: String
    var exercises: [ConfiguredExercise]
    
    init (_ name: String, goal: String, _ exercises: [ConfiguredExercise]){
        self.name = name
        self.goal = goal
        self.exercises = exercises
    }
    
    // MARK : Methods
    
}
