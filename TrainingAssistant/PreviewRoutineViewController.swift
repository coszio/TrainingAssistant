//
//  PreviewRoutineViewController.swift
//  TrainingAssistant
//
//  Created by user181023 on 10/25/20.
//

import UIKit

class PreviewRoutineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var routine: Routine!
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbTotalTime: UILabel!
    
    @IBOutlet weak var lbGoal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: Table View Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routine.exercises!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "confExerciseCell", for: indexPath)
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "begin" {
            // Get the new view controller using segue.destination.
            let executionView = segue.destination as! ExecuteRoutineViewController
            // Pass the selected object to the new view controller.
            executionView.routine = self.routine
        }
        
    }
    

}
