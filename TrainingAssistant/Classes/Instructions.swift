//
//  Instructions.swift
//  TrainingAssistant
//
//  Created by user180996 on 10/21/20.
//

import Foundation

/*
 This class is the basis for every exercise to be performed
 during a routine workout.
 isRepBased is used to specify the way the exercise will be
    measured, either by time or by repetitions.
*/

class Instructions : NSObject {
    var isRepBased : Bool
    var reps : Int?
    var time : TimeInterval?
    var sets : Int
    var restTime : TimeInterval
    var finalRestTime : TimeInterval
    var notes : String?
    
    //More options
    init (_ ins : Instructions){
        self.isRepBased = ins.isRepBased
        self.reps = ins.reps
        self.time = ins.time
        self.sets = ins.sets
        self.restTime = ins.restTime
        self.finalRestTime = ins.finalRestTime
        self.notes = ins.notes
    }
    
    //Rep based initializer
    init (_ exercise : Exercise, _ isRepBased : Bool, _ reps : Int,
          _ sets : Int, _ restTime : TimeInterval, _ finalRestTime : TimeInterval,
          _ notes : String?){
        self.isRepBased = isRepBased
        self.reps = reps
        self.sets = sets
        self.restTime = restTime
        self.finalRestTime = finalRestTime
        self.notes = notes
    }
    
    //Time based initializer
    init (_ exercise : Exercise, _ isRepBased : Bool, _ time : TimeInterval,
          _ sets : Int, _ restTime : TimeInterval, _ finalRestTime : TimeInterval,
          _ notes : String?){
        self.isRepBased = isRepBased
        self.time = time
        self.sets = sets
        self.restTime = restTime
        self.finalRestTime = finalRestTime
        self.notes = notes
    }
    
    init (_ exercise : Exercise, _ isRepBased : Bool, _ reps : Int?,
          _ time : TimeInterval, _ sets : Int, _ restTime : TimeInterval,
          _ finalRestTime : TimeInterval, _ notes : String?){
        self.isRepBased = isRepBased
        self.reps = reps
        self.time = time
        self.sets = sets
        self.restTime = restTime
        self.finalRestTime = finalRestTime
        self.notes = notes
    }
}
