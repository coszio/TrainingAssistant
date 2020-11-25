//
//  ExecuteRoutineViewController.swift
//  TrainingAssistant
//
//  Created by user181023 on 10/25/20.
//

import UIKit
import AVFoundation

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
    
    var audioPlayer: AVAudioPlayer?
    
    var startTime: Date?
    
    var schedule: [(Exercise, TimeInterval, String, Instructions, Int)] = []
    var currentStep: Int = 0
    var currExercise: Int = 0
    var exercises: [ConfiguredExercise] {
        return routine.exercises!.array as! [ConfiguredExercise]
    }
    var step: (Exercise,TimeInterval,String, Instructions, Int)? {
        let ex = routine.exercises?.array as! [ConfiguredExercise]
        if let sched = ex.indices.contains(currExercise) ? ex[currExercise].steps : nil {
            
            return sched.indices.contains(currentStep) ? sched[currentStep] : nil
        }
        print("No exercise at index %i",currExercise)
        
        return nil
    }
    var timeLeft: TimeInterval = 0
    var timer = Timer()
    var isTimerRunning: Bool = false
    var isPauseTapped = false
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults.setValue(10.0, forKey: "prepareTime") //temporal
        
        indicatorCard.layer.cornerRadius = 10
        
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
                playSound(soundName: "countdownfinishSFX")
                advanceSteps(1)
            }
        if 1...3 ~= timeLeft {
            //play leadingSFX
            playSound(soundName: "countdownSFX")
        }
    }

    func advanceExercise(_ amount: Int) {
        
        var realAmount = amount
        
        if amount < 0 && currentStep > 0 {
            currentStep = 0
            realAmount += 1
        }
        
        currExercise += realAmount
        
        if currExercise < 0 {
            //do nothing
            currExercise = 0
        }
        else if currExercise >= exercises.count {
            currExercise = exercises.count - 1
            //terminate execution
            timer.invalidate()
            
            //go to log
            endWorkout()
        }
        else {
            currentStep = 0
            updateToCurrentStep()
        }
    }
    func advanceSteps(_ amount: Int) {
        //go to next step
        currentStep += amount
        
        if currentStep < 0 {
            //go to prev exercise
            advanceExercise(-1)
            
            //set current step to the last
            currentStep = exercises[currExercise].steps.count - 1
            updateToCurrentStep()
        }
        
        //is there a next step?
        else if currentStep >= exercises[currExercise].steps.count{
            advanceExercise(1)
        }
        
        else{
            // it is within the same exercise
            updateToCurrentStep()
        }
    }
    func updateToCurrentStep() {
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
        
        lbTotalTime.text = (-startTime!.timeIntervalSinceNow).toString()
        
        switch step!.2 {
        case "Prepare":
            indicatorCard.backgroundColor = .yellow
            break
        case "Work":
            indicatorCard.backgroundColor = .green
            break
        case "Rest":
            indicatorCard.backgroundColor = UIColor(red: 0.55, green: 0.6, blue: 1, alpha: 1)
            break
        case "Cooldown":
            indicatorCard.backgroundColor = .lightGray
            break
        default:
            break
        }
        view.backgroundColor = indicatorCard.backgroundColor?.withAlphaComponent(0.3)
        lbSeries.text = String(format: "%i / %i", step!.4, step!.3.sets)
        
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
        advanceExercise(1)
    }
    
    @IBAction func prevExercise(_ sender: UIButton) {
        advanceExercise(-1)
    }
    func endWorkout() {
        performSegue(withIdentifier: "log workout", sender: self)
    }
    func playSound(soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else {
            print("url not found")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.volume = 0.8
            audioPlayer?.play()
        } catch {
            print("Could not play audio " + soundName)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "log workout" {
            let vistaLog = segue.destination as! LogViewController
            vistaLog.routine = routine
            vistaLog.totalDuration = -startTime!.timeIntervalSinceNow
        }
        // Pass the selected object to the new view controller.
    }
    

}
extension ConfiguredExercise {
    var steps: [(Exercise, TimeInterval, String, Instructions, Int)] {
        let defaults = UserDefaults()
        var sched: [(Exercise, TimeInterval, String, Instructions, Int)] = []
        sched.append((self.exercise!,defaults.double(forKey: "prepareTime"), "Prepare", self.instructions!, 1))
        	
        for i in 1..<self.instructions!.sets {
            sched.append((self.exercise!,self.instructions!.time, "Work", self.instructions!, Int(i)))
            sched.append((self.exercise!,self.instructions!.restTime, "Rest", self.instructions!, Int(i)))
        }
        sched.append((self.exercise!,self.instructions!.time, "Work", self.instructions!, Int(self.instructions!.sets)))
        sched.append((self.exercise!,self.instructions!.finalRestTime, "Cooldown", self.instructions!, Int(self.instructions!.sets)))
        return sched
    }

}
