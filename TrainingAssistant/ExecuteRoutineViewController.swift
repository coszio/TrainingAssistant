//
//  ExecuteRoutineViewController.swift
//  TrainingAssistant
//
//  Created by user181023 on 10/25/20.
//

import UIKit

class ExecuteRoutineViewController: UIViewController {

    var routine: Routine!
    
    let defaults = UserDefaults()
    @IBOutlet weak var lbRoutine: UILabel!
    
    @IBOutlet weak var lbTotalTime: UILabel!
    
    
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var tvNotes: UITextView!
    @IBOutlet weak var lbExercise: UILabel!
    
    @IBOutlet weak var indicatorCard: UIView!
    
    @IBOutlet weak var lbCurrentTime: UILabel!
    @IBOutlet weak var lbIndication: UILabel!
    
    @IBOutlet weak var btPlayPause: UIButton!
    
    @IBOutlet weak var btPreviousStep: UIButton!
    @IBOutlet weak var btNextStep: UIButton!
    
    @IBOutlet weak var btPreviousExercise: UIButton!
    @IBOutlet weak var btNextExercise: UIButton!
    
    @IBOutlet weak var lbSeries: UILabel!
    
    var startTime: Date?
    
    var schedule: [(Exercise, TimeInterval, String, Instructions, Int)] = []
    var currentStep: Int = 0
    var step: (Exercise,TimeInterval,String, Instructions, Int)? {
        return schedule.indices.contains(currentStep) ? schedule[currentStep] : nil
    }
    var timeLeft: TimeInterval = 0
    var timer = Timer()
    var isTimerRunning: Bool = false
    var isPauseTapped = false
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults.setValue(10.0, forKey: "prepareTime") //temporal
        
        for confEx in routine.exercises!.array as! [ConfiguredExercise] {
            schedule += confEx.generateSchedule()
        }
        
        executeWorkout()
        // Do any additional setup after loading the view.
    }
    
    func executeWorkout() {
        startTime = Date()
        //let timer = Timer()
        
        
        timeLeft = step!.1
        updateAllLabels()
        runTimer()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
            //one second has passed
        
            if timeLeft > 0 {
                //there is still time in the clock
                timeLeft -= 1
                
                //update labels
                if !(step!.3.isRepBased && step!.2 == "Work") {
                    lbCurrentTime.text = timeLeft.toString()
                }
                lbTotalTime.text = (-startTime!.timeIntervalSinceNow).toString()
            } else {
                //timer hits 0
                advanceSteps(1)
            }
        if 1...3 ~= timeLeft {
            //TODO: play leadingSFX
        }
    }

    func advanceSteps(_ amount: Int) {
        //go to next step
        currentStep += amount
        
        //is there a next step?
        if step != nil {
            if step!.2 == "Work" && step!.3.isRepBased { // it is a rep based exercise
                timeLeft = 1000000000
                //wait for user to advance to next step
                // by pressing the next step button
            } else {
                //update time left
                timeLeft = step!.1
            }
            //update screen
            updateAllLabels()
        }
        else {
            //there are no steps left
            timer.invalidate()
            //terminate execution
            
            //go to log
        }
    }
    func updateAllLabels() {
        
        lbRoutine.text = routine.name
        
        if step!.3.isRepBased && step!.2 == "Work" {
            
            lbCurrentTime.text = String(step!.3.reps) + " reps"
            
        } else {
            
            lbCurrentTime.text = step!.1.toString()
            
        }
        lbExercise.text = step!.0.name
        
        lbIndication.text = step!.2
        
        tvDescription.text = step!.0.desc
        
        tvNotes.text = step!.3.note
        
        lbTotalTime.text = startTime?.timeIntervalSinceNow.toString()
        
        switch step!.2 {
        case "Prepare":
            indicatorCard.backgroundColor = .yellow
            break
        case "Work":
            indicatorCard.backgroundColor = .green
            break
        case "Rest":
            indicatorCard.backgroundColor = .blue
            break
        case "Cooldown":
            indicatorCard.backgroundColor = .lightGray
            break
        default:
            break
        }
        
        lbSeries.text = String(format: "% / %", step!.4, step!.3.sets)
        
    }
    
    @IBAction func playPauseTap(_ sender: UIButton) {
        if isPauseTapped {
            runTimer()
            isTimerRunning = true
            isPauseTapped = false
            //switch icon and label
            btPlayPause.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        } else {
            timer.invalidate()
            isTimerRunning = false
            isPauseTapped = true
            //switch icon and label
            btPlayPause.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        }
    }
    
    @IBAction func nextStepTap(_ sender: UIButton) {
        advanceSteps(1)
    }
    
    @IBAction func prevStepTap(_ sender: UIButton) {
        advanceSteps(-1)
    }
    
    @IBAction func nextExerciseTap(_ sender: UIButton) {
        //figure out how many steps are required to advance
        //let stepRightNow = currentStep
        repeat {
            if step != nil{
                currentStep += 1
            } else {
                //end workout
            }
        } while step!.2 != "Prepare"
        advanceSteps(0)
    }
    
    @IBAction func prevExercise(_ sender: UIButton) {
        //figure out how many steps are needed to move
        repeat {
            if step != nil {
                currentStep -= 1
            } else {
                //
            }
        } while step!.2 != "Prepare"
        advanceSteps(0)
        
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
extension ConfiguredExercise {
    func generateSchedule() -> [(Exercise, TimeInterval, String, Instructions, Int)] {
        let defaults = UserDefaults()
        var sched: [(Exercise, TimeInterval, String, Instructions, Int)] = []
        sched.append((self.exercise!,defaults.double(forKey: "prepareTime"), "Prepare", self.instructions!, -1))
        
        for i in 1..<self.instructions!.sets {
            sched.append((self.exercise!,self.instructions!.time, "Work", self.instructions!, Int(i)))
            sched.append((self.exercise!,self.instructions!.restTime, "Rest", self.instructions!, Int(i)))
        }
        sched.append((self.exercise!,self.instructions!.time, "Work", self.instructions!, Int(self.instructions!.sets)))
        sched.append((self.exercise!,self.instructions!.finalRestTime, "Cooldown", self.instructions!, -1))
        return sched
    }
}
