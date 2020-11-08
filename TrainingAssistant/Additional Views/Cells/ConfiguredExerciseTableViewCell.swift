//
//  ConfiguredExerciseTableViewCell.swift
//  TrainingAssistant
//
//  Created by user181023 on 11/1/20.
//

import UIKit

class ConfiguredExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubtitle: UILabel!
    @IBOutlet weak var lbWork: UILabel!
    @IBOutlet weak var lbRest: UILabel!
    @IBOutlet weak var lbSets: UILabel!
    @IBOutlet weak var lbCooldown: UILabel!
    @IBOutlet weak var lbNote: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
