//
//  ExecuteRoutineViewController.swift
//  TrainingAssistant
//
//  Created by user181023 on 10/25/20.
//

import UIKit

class ExecuteRoutineViewController: UIViewController {

    var routine: Routine!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
