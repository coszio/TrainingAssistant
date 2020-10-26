//
//  ConfigureExerciseVC.swift
//  TrainingAssistant
//
//  Created by user180996 on 10/23/20.
//

import UIKit

class ConfigureExerciseVC: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    var views : [UIView]!
    var isTimeBased : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        views = [UIView]()
        views.append(SetBasedVC().view)
        views.append(TimeBasedVC().view)
        
        for v in views{
            viewContainer.addSubview(v)
        }
        
        viewContainer.bringSubviewToFront(views[0])
    }
    
    //This function is in charge of changing the view that should be presented and establishing the type of configuration that will be set
    @IBAction func changeView(_ sender: UISegmentedControl) {
        self.viewContainer.bringSubviewToFront(views[sender.selectedSegmentIndex])
        
        switch sender.selectedSegmentIndex {
        case 1:
            isTimeBased = true
        default:
            isTimeBased = false
        }
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
