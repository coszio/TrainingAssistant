//
//  RoutineTableViewCell.swift
//  TrainingAssistant
//
//  Created by user181023 on 10/16/20.
//

import UIKit

class RoutineTableViewCell: UITableViewCell {

    @IBOutlet weak var card: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        card.clipsToBounds = true
        card.layer.cornerRadius = 15
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
