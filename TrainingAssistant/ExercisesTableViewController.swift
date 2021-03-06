//
//  ExercisesTableViewController.swift
//  TrainingAssistant
//
//  Created by user181023 on 10/16/20.
//

import UIKit

class ExercisesTableViewController: UITableViewController, addInstructionsProtocol, editRoutineProtocol, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var btSave: UIBarButtonItem!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var exercises: [Exercise] = []
    var confExercises: [ConfiguredExercise] = []
    var routineName: String?
    var routineGoal: String?
    var routineAux: Routine?
    var edit: Bool = false
    let headers = ["Routine", "Existing Exercises"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "ConfiguredExerciseTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ConfiguredExerciseTableViewCell")
        
        fetchExercises()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func fetchExercises() {
        //fetch the data from Core Data to display in the tableview
        do {
            //fetch all exercises
            exercises = try context.fetch(Exercise.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            
        }
        
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        switch section {
        case 0:
            return confExercises.count
        case 1:
            return exercises.count
        default:
            return 0
        }
        
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel()
        label.text = headers[section]
        label.backgroundColor = UIColor.lightGray
        
        return label
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exerciseCell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath)
        
        let idx = indexPath.row
        
        switch indexPath.section {
        
        case 0:
            let confExerCell = tableView.dequeueReusableCell(withIdentifier: "ConfiguredExerciseTableViewCell", for: indexPath) as! ConfiguredExerciseTableViewCell
            
            confExerCell.lbTitle.text = confExercises[idx].exercise!.name
            
            confExerCell.lbSubtitle.text = confExercises[idx].exercise!.focus
            
            if confExercises[idx].instructions!.isRepBased {
                confExerCell.lbWork.text = String(confExercises[idx].instructions!.reps) + " reps"
            }
            else {
                confExerCell.lbWork.text = TimeInterval( confExercises[idx].instructions!.time).toString()
            }
            
            confExerCell.lbRest.text = TimeInterval( confExercises[idx].instructions!.restTime).toString()
            
            confExerCell.lbSets.text = String(confExercises[idx].instructions!.sets)
            
            confExerCell.lbCooldown.text = TimeInterval( confExercises[idx].instructions!.finalRestTime).toString()

            confExerCell.lbNote.text = confExercises[idx].instructions!.note
            
            return confExerCell
            
        case 1:
            exerciseCell.textLabel?.text = exercises[idx].name
            
            exerciseCell.detailTextLabel?.text = exercises[idx].focus
            
            return exerciseCell
            
        default:
            return exerciseCell
            
        }
            
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Which item to remove
            switch indexPath.section {
            case 0:
                let itemToRemove = self.confExercises[indexPath.row]
                
                //Remove the item
                self.context.delete(itemToRemove)
                
                //Save the data
                do {
                    try self.context.save()
                }
                catch {
                    
                }
                
                // Delete the row from the data source
                confExercises.remove(at: indexPath.row)
                
                // This is in order to have an animation and update the table
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                break
                
            case 1:
                let itemToRemove = self.exercises[indexPath.row]
                
                //Remove the item
                self.context.delete(itemToRemove)
                
                //Save the data
                do {
                    try self.context.save()
                }
                catch {
                    
                }
                
                // Delete the row from the data source
                exercises.remove(at: indexPath.row)
                // This is in order to have an animation
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                //Re-fetch the data
                self.fetchExercises()
                break
            default:
                break
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    //MARK: - Protocols
    
    func addInstructions(_ instructions: Instructions, _ exercise: Exercise) {
        let confEx = ConfiguredExercise(context: context)
        confEx.instructions = instructions
        confEx.exercise = exercise//s[tableView.indexPathForSelectedRow!.row]
        confExercises.append(confEx)
        tableView.reloadData()
    }
    func extractRoutineData(_ routine: Routine) {
        confExercises = routine.exercises?.array as! [ConfiguredExercise]
        routineName = routine.name
        routineGoal = routine.goal
        routineAux = routine
        edit = true
    }
    func adaptivePresentationStyle (for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    // MARK: - Navigation
    
    func insertRoutine() {
//
        
        let routine = edit ? routineAux! : Routine(context: self.context)
//
        routine.name = routineName

        routine.goal = routineGoal
        
        routine.exercises = []
        
        for confEx in confExercises {
            
            routine.addToExercises(confEx)
            
        }
        do{
            try context.save()
        } catch {
          print("Could not save routine")
        }
    }
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        dismiss(animated: true, completion: nil)
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "configure" {
            let vistaInstruc = segue.destination as! InstructionsViewController
            vistaInstruc.delegate = self
            vistaInstruc.exercise = exercises[tableView.indexPathForSelectedRow!.row]
        }
        else if segue.identifier == "newExercise" {
            let vistaNewExercise = segue.destination as! NewExerciseViewController
            vistaNewExercise.addToconfExDelegate = self
        }
        else if segue.identifier == "seguePopOver" {
            let vistaPopOver = segue.destination as! RoutineDetailsViewController
            vistaPopOver.popoverPresentationController!.delegate = self
            if edit {
                vistaPopOver.name = routineName
                vistaPopOver.goal = routineGoal
            }
        }
    }

    @IBAction func unwindToExerciseTable(_ unwindSegue: UIStoryboardSegue) {
        //let newExerciseView = unwindSegue.source as! NewExerciseViewController
        if unwindSegue.identifier == "Configure" {
            //let vistaConf = unwindSegue.source as! InstructionsViewController
        }
        tableView.reloadData()
        fetchExercises()
    }
    @IBAction func unwindToSave(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source as! RoutineDetailsViewController
        insertRoutine()
        if edit {
            performSegue(withIdentifier: "unwindToPreview", sender: self)
        } else {
            performSegue(withIdentifier: "unwindToRoutines", sender: self)
        }
        // Use data from the view controller which initiated the unwind segue
    }
}


extension TimeInterval {
    func toString() -> String {
        let interval =  Int(self)
        let hours = interval / (60 * 60)
        let minutes = (interval % (60 * 60)) / 60
        let secs = ((interval % (60 * 60)) % 60)
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, secs)
        } else {
            return String(format: "%02d:%02d", minutes, secs)
        }
    }
}
