//
//  RoutineExerciseConfigVC.swift
//  TrainingAssistant
//
//  Created by user180996 on 10/26/20.
//

import UIKit

class RoutineExerciseConfigVC: UIViewController {
    
    @IBOutlet weak var viewContainer: UIView!
    var views : [UIView]!
    var isTimeBased : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        views = [UIView]()
        views.append(RepBasedVC().view)
        views.append(TimeBasedVC().view)
        
        for v in views{
            viewContainer.addSubview(v)
        }
        
        views[0].isHidden = false
        views[1].isHidden = true
        
        viewContainer.bringSubviewToFront(views[0])
    }
    
    @IBAction func changeConfigView(_ sender: UISegmentedControl) {
        viewContainer.bringSubviewToFront(views[sender.selectedSegmentIndex])
        
        switch(sender.selectedSegmentIndex){
        case 1:
            views[0].isHidden = true
            views[1].isHidden = false
            isTimeBased = true
            break
        default:
            views[0].isHidden = false
            views[1].isHidden = true
            isTimeBased = false
            break
        }
    }
    
    @IBAction func cancelConfig(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveConfig(_ sender: Any) {
        //Temporary
        //Just dismiss the view for now
        dismiss(animated: true, completion: nil)
    }
    // MARK - Gesture Recognizers
    
    //Used to remove the keyboard from the screen
    @IBAction func hideKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
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
