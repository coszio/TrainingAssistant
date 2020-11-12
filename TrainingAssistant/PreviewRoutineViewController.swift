//
//  PreviewRoutineViewController.swift
//  TrainingAssistant
//
//  Created by user181023 on 10/25/20.
//

import UIKit

class PreviewRoutineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var routine: Routine!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbTotalTime: UILabel!
    
    @IBOutlet weak var lbGoal: UILabel!
    
    var exercises: [ConfiguredExercise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbTitle.text = routine.name
        lbGoal.text = routine.goal
        lbTotalTime.text = routine.getTotalTime().toString()
        let nib = UINib(nibName: "ConfiguredExerciseTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ConfiguredExerciseTableViewCell")
        exercises = routine.exercises?.array as! [ConfiguredExercise]
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    // MARK: Table View Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let confExerCell = tableView.dequeueReusableCell(withIdentifier: "ConfiguredExerciseTableViewCell", for: indexPath) as! ConfiguredExerciseTableViewCell
        
        let idx = indexPath.row
        
        confExerCell.lbTitle.text = exercises[idx].exercise!.name
        
        confExerCell.lbSubtitle.text = exercises[idx].exercise!.focus
        
        if exercises[idx].instructions!.isRepBased {
            confExerCell.lbWork.text = String(exercises[idx].instructions!.reps) + " reps"
        }
        else {
            confExerCell.lbWork.text = TimeInterval( exercises[idx].instructions!.time).toString()
        }
        
        confExerCell.lbRest.text = TimeInterval( exercises[idx].instructions!.restTime).toString()
        
        confExerCell.lbSets.text = String(exercises[idx].instructions!.sets)
        
        confExerCell.lbCooldown.text = TimeInterval( exercises[idx].instructions!.finalRestTime).toString()

        confExerCell.lbNote.text = exercises[idx].instructions!.note
        
        return confExerCell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "begin" {
            // Get the new view controller using segue.destination.
            let executionView = segue.destination as! ExecuteRoutineViewController
            // Pass the selected object to the new view controller.
            executionView.routine = self.routine
        } else if segue.identifier == "editRoutine" {
            let confRoutineView = segue.destination as! ExercisesTableViewController
//            confRoutineView.routine = routine
//            confRoutineView.confExercises = exercises
//            confRoutineView.routineName = routine.name
//            confRoutineView.routineGoal = routine.goal
        }
    }
    

}
