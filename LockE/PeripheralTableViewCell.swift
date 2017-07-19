//
//  PeripheralTableViewCell.swift
//  LockE Controller
//
//  Created by Alexander Li on 6/29/17.
//  Copyright © 2017 Alexander Li. All rights reserved.
//

import UIKit

class PeripheralTableViewCell: UITableViewCell {
    
    //MARK: Properties

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var bluetoothImage: UIImageView!
    @IBAction func tableConnectButton(_ sender: Any) {
        Peripheral.chosenPeripheralIndex = findPeripheral(name: nameLabel.text!)
        Peripheral.peripheralChosen = true
        cellView.backgroundColor = UIColor.lightGray
        nameLabel.textColor = UIColor.white
        tableConnectButtonOutlet.setTitle("Click Done", for: .normal)
        tableConnectButtonOutlet.setTitleColor(UIColor.black, for: .normal)

    }
    @IBOutlet weak var tableConnectButtonOutlet: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func findPeripheral(name: String) -> Int {
        let index = Peripheral.peripheralNames.index(of: name)
        //return Peripheral.peripherals[index!]
        return index!
    }
    
    

}
