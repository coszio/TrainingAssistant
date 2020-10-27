//
//  WorkoutsTableViewController.swift
//  TrainingAssistant
//
//  Created by user181023 on 10/15/20.
//

import UIKit

class RoutinesTableViewController: UITableViewController {

    var items: [Routine] = [Routine]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let nib = UINib(nibName: "routineCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "routineCell")
        fetchRoutines()
    }

    func fetchRoutines() {
        
        do {
            items = try context.fetch(Routine.fetchRequest())
            tableView.reloadData()
        }
        catch {
            
        }
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routineCell", for: indexPath) as! RoutineTableViewCell
        let idx = indexPath.row
        cell.lbTitle.text = items[idx].name
        cell.lbGoal.text = items[idx].goal
        
        var summary: String = (items[idx].exercises?.allObjects[0] as! Exercise).name ?? ""
        for n in 1...2 {
            summary += ", "
            summary += (items[idx].exercises?.allObjects[n] as! Exercise).name ?? ""
        }
        summary += "..."
        
        cell.lbSummary.text = summary
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "preview" {
            // Get the new view controller using segue.destination.
            let preview = segue.destination as! PreviewRoutineViewController
            // Pass the selected object to the new view controller.
            preview.routine = items[tableView.indexPathForSelectedRow!.row]
        }
        
    }
    
    @IBAction func unwindToRoutines(_ unwindSegue: UIStoryboardSegue) {
        let sourceVC = unwindSegue.source as! ExercisesTableViewController
        // Use data from the view controller which initiated the unwind segue
        
        self.fetchRoutines()
    }

}
