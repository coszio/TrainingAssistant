//
//  LogViewController.swift
//  TrainingAssistant
//
//  Created by user181023 on 11/23/20.
//

import UIKit

class LogViewController: UIViewController {

   
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbCompletion: UILabel!
    @IBOutlet weak var stCompletion: UIStepper!
    @IBOutlet weak var lbTotalTime: UILabel!
    @IBOutlet weak var slIntensity: UISlider!
    @IBOutlet weak var tvComments: UITextView!
    
    var routine: Routine!
    var totalDuration: Double!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        lbTitle.text = routine.name
        lbTotalTime.text = TimeInterval(totalDuration).toString()
        lbCompletion.text = String(stCompletion.value * 100) + "%"
        // Do any additional setup after loading the view.
    }
    @IBAction func stepperTapped(_ sender: UIStepper) {
        lbCompletion.text = String(sender.value * 100) + "%"
    }
    func collectData(into log: Log) {
        log.routine = routine
        log.date = Date()
        log.totalDuration = totalDuration
        log.execution = stCompletion.value
        log.intensity = Double(slIntensity.value)
        log.comment = tvComments.text
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
