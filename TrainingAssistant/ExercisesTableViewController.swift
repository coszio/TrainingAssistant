//
//  ExercisesTableViewController.swift
//  TrainingAssistant
//
//  Created by user181023 on 10/16/20.
//

import UIKit

class ExercisesTableViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items: [Exercise] = []
    //var ejerciciosEjemplo: [Ejercicio] = [Ejercicio(nombre: "Sentadillas", descripcion: "Bajar con la espalda recta hasta alcanzar 90 grados con las piernas y subir", url: nil), Ejercicio(nombre: "Lagartijas", descripcion: "Mantener las piernas y el torso alineados, bajar controladamente hasta que el pecho quede a 5 cm del suelo", url: nil)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            items = try context.fetch(Exercise.fetchRequest())
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return items.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath)
        let idx = indexPath.row
        
        cell.textLabel?.text = items[idx].name
        cell.detailTextLabel?.text = items[idx].focus
        return cell
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
            // Delete the row from the data source
            //Which item to remove
            let itemToRemove = self.items[indexPath.row]
            
            //Remove the item
            self.context.delete(itemToRemove)
            
            //Save the data
            do {
                try self.context.save()
            }
            catch {
                
            }
            
            //Re-fetch the data
            self.fetchExercises()
        }
        else if editingStyle == .insert {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func unwindToExerciseTable(_ unwindSegue: UIStoryboardSegue) {
        //let newExerciseView = unwindSegue.source as! NewExerciseViewController
        
        fetchExercises()
    }
}
