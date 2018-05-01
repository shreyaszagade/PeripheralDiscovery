//
//  BluetoothDeviceCell.swift
//  PeripheralDiscovery
//
//  Created by Shreyas Zagade on 4/30/18.
//  Copyright © 2018 Zagade. All rights reserved.
//

import UIKit

class BluetoothDeviceCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var uuidLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
