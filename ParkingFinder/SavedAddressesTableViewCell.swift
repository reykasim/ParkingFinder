//
//  SavedAddressesTableViewCell.swift
//  ParkingFinder
//
//  Created by Vivian The on 22/5/2022.
//

import UIKit

class SavedAddressesTableViewCell: UITableViewCell {

    @IBOutlet var carparkName: UILabel!
    @IBOutlet var carparkCor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
