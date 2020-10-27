//
//  InstructionsViewController.swift
//  TrainingAssistant
//
//  Created by user181023 on 10/27/20.
//

import UIKit

class InstructionsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var scTimeReps: UISegmentedControl!
    
    @IBOutlet weak var pickerWork: UIPickerView!
    @IBOutlet weak var pickerRest: UIPickerView!
    @IBOutlet weak var pickerSets: UIPickerView!
    @IBOutlet weak var pickerCoolDown: UIPickerView!
    
    var isRepBased: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickers = [pickerWork, pickerRest, pickerSets, pickerCoolDown]
        for picker in pickers {
            picker?.delegate = self
            picker?.dataSource = self
        }
//        isRepBased ? pickerWork.selectRow(10, inComponent: 0, animated: false) : pickerWork.selectRow(15, inComponent: 2, animated: false)
//        pickerRest.selectRow(20, inComponent: 2, animated: false)
//        pickerSets.selectRow(4, inComponent: 0, animated: false)
//        pickerCoolDown.selectRow(1, inComponent: 1, animated: false)
        // Do any additional setup after loading the view.
    }
    @IBAction func timeRepsChanged(_ sender: UISegmentedControl) {
        isRepBased = sender.selectedSegmentIndex == 0
        pickerWork.reloadAllComponents()
    }
    
    // MARK: - PickerViews
    let repNumbers = Array(1...500)
    let setNumbers = Array(1...100)
    let timeNumbers = [Array(0...23), Array(0...59), Array(0...59)]
    let timeTitles = ["hours", "mins", "secs"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView.tag {
        case 0:
            //Work PickerView
            return isRepBased ? 1 : timeNumbers.count
        case 1:
            //Rest PickerView
            return timeNumbers.count
        case 2:
            //Sets PickerView
            return 1
        case 3:
            //Cooldown PickerView
            return timeNumbers.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerWork {
            return isRepBased ? repNumbers.count : timeNumbers[component].count
        }
        else if pickerView == pickerRest {
            return timeNumbers[component].count
        }
        else if pickerView == pickerSets {
            return setNumbers.count
        }
        else if pickerView == pickerCoolDown {
            return timeNumbers[component].count
        }
        else {
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            //Work PickerView
            return isRepBased ? String(repNumbers[row]) : String(timeNumbers[component][row])
        case 1:
            //Rest PickerView
            return String(timeNumbers[component][row])
        case 2:
            //Sets PickerView
            return String(setNumbers[row])
        case 3:
            //Cooldown PickerView
            return String(timeNumbers[component][row])
        default:
            return ""
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
