//
//  ConfiguredExercise.swift
//  TrainingAssistant
//
//  Created by user180996 on 10/21/20.
//

import Foundation

class ConfiguredExercise : Exercise{
    var overallSets: Int
    var overallTime: TimeInterval
    var instruction: Instructions
    
    init(_ exercise: Exercise, _ instruction: Instructions){
        self.overallSets = 0;
        self.overallTime = 0;
        self.instruction = instruction
        super.init(exercise)
    }
    
    // MARK : Methods
    
    // Instructions edited... and so on
}
