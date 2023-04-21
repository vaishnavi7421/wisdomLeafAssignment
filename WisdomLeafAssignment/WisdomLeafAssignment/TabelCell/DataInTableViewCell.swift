//
//  DataInTableViewCell.swift
//  WisdomLeafAssignment
//
//  Created by Pranav Dhomne on 18/04/23.
//

import UIKit

class DataInTableViewCell: UITableViewCell {

    @IBOutlet weak var imageData: UIImageView!
    @IBOutlet weak var titleData: UILabel!
    @IBOutlet weak var descrData: UILabel!
    @IBOutlet weak var checkBox: UIButton!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func checkBoxAction(_ sender: Any) {
        if  GlobalCall.shared.isButtonSelected == false {
            checkBox.setImage(UIImage(systemName: "square"), for: .normal)
            GlobalCall.shared.isButtonSelected = true
        } else {
            checkBox.setImage(UIImage(systemName: "checkmark"), for: .normal)
            GlobalCall.shared.isButtonSelected = false

        }
        
    }
}
