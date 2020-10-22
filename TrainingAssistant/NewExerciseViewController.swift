//
//  NewExerciseViewController.swift
//  TrainingAssistant
//
//  Created by user181023 on 10/21/20.
//

import UIKit

class NewExerciseViewController: UIViewController {
    
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfDescription: UITextView!
    @IBOutlet weak var tfFocus: UITextField!
    
    @IBOutlet weak var btSave: UIBarButtonItem!
    @IBOutlet weak var btSaveAndConfigure: UIButton!
    
    var exercise: Exercise!
    var addedExercise: Exercise!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func quitaTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if tfTitle.text == "" || tfFocus.text! == "" {
            let alerta = UIAlertController(title: "Error", message: "Please fill Exercise and Focus fields", preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alerta.addAction(accion)
            present(alerta, animated: true, completion: nil)
            return false
        }
        else {
            return true
        }
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        addedExercise = Exercise(tfTitle.text!, tfDescription.text, tfFocus.text!)
        // Pass the selected object to the new view controller.
    }
    

}
