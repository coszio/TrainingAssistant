//
//  InstructionsViewController.swift
//  TrainingAssistant
//
//  Created by user181023 on 10/27/20.
//

import UIKit
protocol addInstructionsProtocol {
    func addInstructions(_ instructions: Instructions, _ exercise: Exercise)
}
class InstructionsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //var instructions: Instructions!
    var selectedIdx: Int!
    var delegate: addInstructionsProtocol!
    
    var exercise: Exercise!
    
    @IBOutlet weak var lbExercise: UILabel!
    
    @IBOutlet weak var scTimeReps: UISegmentedControl!
    
    @IBOutlet weak var pickerWork: UIPickerView!
    @IBOutlet weak var pickerRest: UIPickerView!
    @IBOutlet weak var pickerSets: UIPickerView!
    @IBOutlet weak var pickerCoolDown: UIPickerView!
    @IBOutlet weak var tfNotes: UITextField!
    
    var isRepBased: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickers = [pickerWork, pickerRest, pickerSets, pickerCoolDown]
        for picker in pickers {
            picker?.delegate = self
            picker?.dataSource = self
            
//            TODO: Set units in pickerViews
//            switch picker?.tag {
//            case 0:
//                if isRepBased {
//                    picker?.setPickerLabels(labels: timeLabels, containedView: UIView())
//                }
//                break
//            case 1:
//
//                break
//            case 2:
//
//                break
//            case 3:
//
//                break
//            default:
//                break
//            }
        }
        //TODO: Set initial values
//        isRepBased ? pickerWork.selectRow(10, inComponent: 0, animated: false) : pickerWork.selectRow(15, inComponent: 2, animated: false)
//        pickerRest.selectRow(20, inComponent: 2, animated: false)
//        pickerSets.selectRow(4, inComponent: 0, animated: false)
//        pickerCoolDown.selectRow(1, inComponent: 1, animated: false)
        lbExercise.text = exercise.name
        // Do any additional setup after loading the view.
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func timeRepsChanged(_ sender: UISegmentedControl) {
        isRepBased = sender.selectedSegmentIndex == 0
        pickerWork.reloadAllComponents()
    }
    func collectTime(fromPicker: UIPickerView) -> Double {
        var time: TimeInterval = 0
        //secs
        time += Double(fromPicker.selectedRow(inComponent: 2))
        
        //mins
        time += Double(fromPicker.selectedRow(inComponent: 1)) * 60
        
        //hours
        time += Double(fromPicker.selectedRow(inComponent: 0)) * 60 * 60
        
        return time
    }
    func collectFromScreen() -> Instructions {
        let instruction = Instructions(context: context)
        instruction.isRepBased = isRepBased
        if isRepBased {
            instruction.reps = Int16(pickerWork.selectedRow(inComponent: 0)) + 1
        }
        else {
            instruction.time = collectTime(fromPicker: pickerWork)
        }
        instruction.restTime = collectTime(fromPicker: pickerRest)
        instruction.sets = Int16(pickerSets.selectedRow(inComponent: 0)) + 1
        instruction.finalRestTime = collectTime(fromPicker: pickerCoolDown)
        instruction.note = tfNotes.text
        return instruction
    }
    // MARK: - PickerViews
    let repNumbers = Array(1...500)
    let setNumbers = Array(1...100)
    let timeNumbers = [Array(0...23), Array(0...59), Array(0...59)]
    let timeUnits = ["hours", "mins", "secs"]
    var timeLabels: [Int : UILabel] {
        var dict = [Int:UILabel]()
        for (i, unit) in timeUnits.enumerated() {
            let label = UILabel()
            label.text = unit
            dict.updateValue(label, forKey: i)
        }
        return dict
    }
    func setTimeLabels(picker: UIPickerView) {
        picker.setPickerLabels(labels: timeLabels, containedView: UIView())
    }
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
            return isRepBased ? String(repNumbers[row]) : String(format: "%02d", timeNumbers[component][row])
        case 1:
            //Rest PickerView
            return String(format: "%02d", timeNumbers[component][row])
        case 2:
            //Sets PickerView
            return String(setNumbers[row])
        case 3:
            //Cooldown PickerView
            return String(format: "%02d", timeNumbers[component][row])
        default:
            return ""
        }
    }
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveConfiguration" {
            delegate.addInstructions(collectFromScreen(), exercise)
        }
    }
    

}
//MARK: - Picker View Extensions
extension UIPickerView {
    func setPickerLabels(labels: [Int:UILabel], containedView: UIView) { // [component number:label]
            
        let fontSize:CGFloat = 20
        let labelWidth:CGFloat = containedView.bounds.width / CGFloat(self.numberOfComponents)
        let x:CGFloat = self.frame.origin.x
        let y:CGFloat = (self.frame.size.height / 2) - (fontSize / 2)
        for i in 0...self.numberOfComponents {
            if let label = labels[i] {
                if self.subviews.contains(label) {
                    label.removeFromSuperview()
                }
                label.frame = CGRect(x: x + labelWidth * CGFloat(i), y: y, width: labelWidth, height: fontSize)
                label.font = UIFont.boldSystemFont(ofSize: fontSize)
                label.backgroundColor = .clear
                label.textAlignment = NSTextAlignment.center
                self.addSubview(label)
            }
        }
    }
}
