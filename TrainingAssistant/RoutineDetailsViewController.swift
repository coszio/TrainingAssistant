//
//  RoutineDetailsViewController.swift
//  TrainingAssistant
//
//  Created by user181023 on 11/7/20.
//

import UIKit

class RoutineDetailsViewController: UIViewController {

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfGoal: UITextField!
    @IBOutlet weak var btSave: UIButton!
    var name: String?
    var goal: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = CGSize(width: 300, height: 200)
        tfName.text = name
        tfGoal.text = goal
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let exercisesView = segue.destination as! ExercisesTableViewController
        exercisesView.routineName = tfName.text
        exercisesView.routineGoal = tfGoal.text
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if tfName.text != "" {
            return true
        } else {
            let alert = UIAlertController(title: "Error", message: "Routine must have a name", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return false
        }
    }

}
